import SwiftUI

struct DrawnClockBorder: View {
    @Environment(\.clockIsAnimationEnabled) var isAnimationEnabled
    @Environment(\.clockRandom) var random
    static let borderWidthRatio: CGFloat = 1/70
    @State private var animate = false

    var body: some View {
        GeometryReader { geometry in
            DrawnCircle(draw: !self.isAnimationEnabled || self.animate, random: self.random)
                .stroke(lineWidth: geometry.diameter * Self.borderWidthRatio)
                .onAppear(perform: { self.animate = true })
                .animation(.easeInOut(duration: 1))
                .aspectRatio(1/1, contentMode: .fit)
        }
    }
}

struct DrawnCircle: Shape {
    private static let marginRatio: CGFloat = 1/80
    private static let numberOfArcs = 26
    private static let angleRatio: Double = 360/Double(Self.numberOfArcs - 1)
    private let maxMarginRatio: CGFloat
    private let angleMarginRatio: Double
    private var circleStep: CGFloat

    init(draw: Bool, random: Random) {
        self.circleStep = draw ? 1 : 0
        self.maxMarginRatio = random.borderMarginRatio.maxMargin(Self.marginRatio)
        self.angleMarginRatio = random.borderMarginRatio.angleMargin()
    }

    var animatableData: CGFloat {
        get { self.circleStep }
        set { self.circleStep = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let diameter = min(rect.width, rect.height)

        path.move(to: .pointInCircle(from: .zero, diameter: diameter))

        let margin = rect.width * self.maxMarginRatio
        for i in 1...Self.numberOfArcs {
            let angle = Angle(degrees: Double(i) * Self.angleRatio)
            let to: CGPoint = .pointInCircle(
                from: angle,
                diameter: diameter,
                margin: margin
            )

            let control: CGPoint = .pointInCircle(
                from: Angle(degrees: angle.degrees - self.angleMarginRatio * Self.angleRatio),
                diameter: diameter,
                margin: margin
            )
            path.addQuadCurve(to: to, control: control)
        }

        return path.trimmedPath(from: 0, to: self.circleStep)
    }
}

#if DEBUG
struct DrawnClockBorder_Previews: PreviewProvider {
    // TODO: get something nice and relevant here and add a snapshot test!
    static var previews: some View {
        DrawnClockBorder()
            .padding()
    }
}
#endif
