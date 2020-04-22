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
            .aspectRatio(1/1, contentMode: .fit)
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
        let bottomRight = CGPoint(
            x: rect.midX + thickness,
            y: rect.midY
        )

        let topY = rect.midY - rect.radius * self.drawStep
        let topCenter = CGPoint(x: rect.radius, y: topY + margin + thickness)
        let topLeft = CGPoint(
            x: topCenter.x - thickness,
            y: topCenter.y
        )

        path.move(to: bottomRight)

        path.addArc(
            center: rect.center,
            radius: thickness,
            startAngle: .zero,
            endAngle: .degrees(180),
            clockwise: false
        )

        let controlLeft = CGPoint(
            x: rect.radius - thickness *  Self.controlRatios.leftX,
            y: topY + thickness + rect.radius * Self.controlRatios.leftY
        )

        path.addQuadCurve(to: topLeft, control: controlLeft)

        path.addArc(
            center: topCenter,
            radius: thickness,
            startAngle: .degrees(180),
            endAngle: .zero,
            clockwise: false
        )

        let controlRight = CGPoint(
            x: rect.radius + thickness *  Self.controlRatios.rightX,
            y: topY + thickness + rect.radius * Self.controlRatios.rightY
        )

        path.addQuadCurve(to: bottomRight, control: controlRight)

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
