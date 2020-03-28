import SwiftUI

struct Moon: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let width = min(rect.width, rect.height)
        let angle = Angle(degrees: 140)
        let startAngle = -Angle(degrees: 90)
        let endAngle = angle - Angle(degrees: 90)
        var path = Path()

        path.addArc(center: center, radius: width/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        let margin: CGFloat = width
        path.addCurve(
            to: .inCircle(rect, for: .zero),
            control1: .inCircle(rect, for: angle * 1/4, margin: margin),
            control2: .inCircle(rect, for: angle * 3/4, margin: margin)
        )

        return path
    }
}

struct Moon_Previews: PreviewProvider {
    static var previews: some View {
        Moon()
            .stroke()
            .padding()
    }
}
