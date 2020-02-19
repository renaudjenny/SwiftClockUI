import SwiftUI

struct DrawnClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/70
    @State private var animate = false

    var body: some View {
        GeometryReader { geometry in
            DrawnCircle(draw: self.animate)
                .stroke(lineWidth: geometry.localDiameter * Self.borderWidthRatio)
                .onAppear(perform: { self.animate = true })
                .animation(.easeInOut(duration: 1))
        }
    }
}

struct DrawnCircle: Shape {
    private static let marginRatio: CGFloat = 1/80
    private static let numberOfArcs = 26
    private static let angleRatio: Double = 360/Double(Self.numberOfArcs - 1)
    private let maxMarginRatio = Current.randomBorderMarginRatio.maxMargin(Self.marginRatio)
    private let angleMarginRatio = Current.randomBorderMarginRatio.angleMargin()
    private var circleStep: CGFloat

    init(draw: Bool) {
        self.circleStep = draw || Current.isAnimationDisabled ? 1 : 0
    }

    var animatableData: CGFloat {
        get { self.circleStep }
        set { self.circleStep = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: .pointInCircle(from: .zero, frame: rect))

        let margin = rect.width * self.maxMarginRatio
        for i in 1...Self.numberOfArcs {
            let angle = Angle(degrees: Double(i) * Self.angleRatio)
            let to: CGPoint = .pointInCircle(
                from: angle,
                frame: rect,
                margin: margin
            )

            let control: CGPoint = .pointInCircle(
                from: Angle(degrees: angle.degrees - self.angleMarginRatio * Self.angleRatio),
                frame: rect,
                margin: margin
            )
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
    }
}
#endif
