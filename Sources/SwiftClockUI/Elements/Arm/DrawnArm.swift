import SwiftUI

struct DrawnArm: View {
    @Environment(\.clockIsAnimationEnabled) var isAnimationEnabled
    @Environment(\.clockRandom) var random
    private static let widthRatio: CGFloat = 1/20
    let type: ArmType
    @State private var showIndicator = false

    var body: some View {
        DrawnArmShape(draw: !isAnimationEnabled || showIndicator, type: type, random: random)
            .onAppear(perform: { self.showIndicator = true })
    }
}

private struct DrawnArmShape: Shape {
    private static let thicknessRatio: CGFloat = 1/30
    let type: ArmType
    private var drawStep: CGFloat
    private static var controlRatios = Random.ControlRatio(random: .fixed)

    init(draw: Bool, type: ArmType, random: Random) {
        self.drawStep = draw ? 1 : 0.1
        self.type = type
        self.generateControlRatiosIfNeeded(random: random)
    }

    var animatableData: CGFloat {
        get { self.drawStep }
        set { self.drawStep = newValue }
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let thickness = rect.radius * Self.thicknessRatio * type.ratio.lineWidth
        let margin = rect.radius * type.ratio.margin

        path.addArc(
            center: rect.center,
            radius: thickness,
            startAngle: .degrees(90),
            endAngle: .zero,
            clockwise: true
        )

        let top = CGPoint(
            x: rect.midX,
            y: rect.midY - rect.radius * self.drawStep + margin + thickness
        )

        let control1 = CGPoint(
            x: rect.midX + thickness - thickness * 2 * Self.controlRatios.leftX,
            y: top.y + rect.radius * Self.controlRatios.leftY
        )
        let control2 = CGPoint(
            x: rect.midX + thickness + thickness * 2 * Self.controlRatios.leftX,
            y: top.y + rect.radius * Self.controlRatios.leftY/2
        )

        path.addCurve(
            to: CGPoint(x: rect.midX + thickness, y: top.y),
            control1: control1,
            control2: control2
        )

        path.addArc(
            center: top,
            radius: thickness,
            startAngle: .zero,
            endAngle: .degrees(270),
            clockwise: true
        )

        path.addVerticalMirror(in: rect)

        return path
    }

    func generateControlRatiosIfNeeded(random: Random) {
        if self.drawStep <= 0 {
            Self.controlRatios = Random.ControlRatio(random: random)
        }
    }
}

#if DEBUG
struct DrawnArm_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            DrawnArm(type: .minute)
        }
        .padding()
    }
}
#endif
