import SwiftUI

struct ArtNouveauArm: Shape {
    let type: ArmType
    private static let widthRatio: CGFloat = 1/40

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let diameter = min(rect.width, rect.height)
        let width = diameter * Self.widthRatio * type.ratio.lineWidth
        let topY = center.y - diameter/2
        let margin = diameter/2 * type.ratio.margin
        let height = diameter/2 - margin

        path.addArc(
            center: center,
            radius: width,
            startAngle: .zero,
            endAngle: .degrees(180),
            clockwise: false
        )

        let top = CGPoint(x: center.x, y: topY + margin)

        let topLeft = CGPoint(x: top.x - width/2, y: top.y)
        let controlLeft1 = CGPoint(x: center.x + width * 2, y: top.y + height * 3/4)
        let controlLeft2 = CGPoint(x: center.x - width * 3, y: top.y + height * 1/5)

        path.addCurve(
            to: topLeft,
            control1: controlLeft1,
            control2: controlLeft2
        )

        path.addArc(
            center: top,
            radius: width/2,
            startAngle: .degrees(180),
            endAngle: .zero,
            clockwise: false
        )

        let bottomRight = CGPoint(x: center.x + width, y: center.y)
        let controlRight1 = CGPoint(x: center.x - width * 2, y: top.y + height * 1/5)
        let controlRight2 = CGPoint(x: center.x + width * 3, y: top.y + height * 3/4)

        path.addCurve(
            to: bottomRight,
            control1: controlRight1,
            control2: controlRight2
        )

        return path
    }
}

#if DEBUG
struct ArtNouveauArm_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArtNouveauArm(type: .minute)
        }
        .aspectRatio(contentMode: .fit)
        .padding()
    }
}
#endif
