import SwiftUI

struct ClassicArm: Shape {
    let type: ArmType
    private static let widthRatio: CGFloat = 1/30

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let diameter = min(rect.width, rect.height)
        let width = diameter * Self.widthRatio * type.ratio.lineWidth

        path.move(to: center)
        path.addArc(
            center: center,
            radius: width/2,
            startAngle: .zero,
            endAngle: .degrees(180),
            clockwise: false
        )

        let topY = center.y - diameter/2
        let margin = diameter/2 * type.ratio.margin

        let topLeft = CGPoint(x: center.x - width/4, y: topY + margin)
        path.addLine(to: topLeft)

        let topRight = CGPoint(x: center.x + width/4, y: topY + margin)
        path.addLine(to: topRight)

        let bottomRight = CGPoint(x: center.x + width/2, y: center.y)
        path.addLine(to: bottomRight)

        return path
    }
}

#if DEBUG
struct ClassicArm_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            ClassicArm(type: .minute)
        }
        .padding()
    }
}
#endif
