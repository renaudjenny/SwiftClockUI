import SwiftUI

struct DrawnClockBorder: View {
    @Environment(\.clockIsAnimationEnabled) var isAnimationEnabled
    @Environment(\.clockRandom) var random
    static let borderWidthRatio: CGFloat = 1/35
    @State private var animate = false

    var body: some View {
        GeometryReader { geometry in
            DrawnCircle(draw: !self.isAnimationEnabled || self.animate, random: self.random)
                .stroke(lineWidth: geometry.radius * Self.borderWidthRatio)
                .onAppear(perform: { self.animate = true })
                .animation(.easeInOut(duration: 1))
                .aspectRatio(contentMode: .fit)
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
        path.move(to: .inCircle(rect, for: .zero))

        // TODO: split this into private addSomething functions
        let margin = rect.width * self.maxMarginRatio
        for i in 1...Self.numberOfArcs {
            let angle = Angle(degrees: Double(i) * Self.angleRatio)
            let to = CGPoint.inCircle(rect, for: angle, margin: margin)

            let controlAngle = Angle(degrees: angle.degrees - self.angleMarginRatio * Self.angleRatio)
            let control = CGPoint.inCircle(rect, for: controlAngle, margin: margin)
            path.addQuadCurve(to: to, control: control)
        }

        return path.trimmedPath(from: 0, to: self.circleStep)
    }
}

#if DEBUG
struct DrawnClockBorder_Previews: PreviewProvider {
    static var previews: some View {
        DrawnClockBorder()
            .padding()
            .environment(\.clockIsAnimationEnabled, false)
    }
}
#endif
