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
            to: CGPoint
                .pointInCircle(from: .zero, diameter: width)
                .recenteredCircle(center: center, diameter: width),
            control1: CGPoint
                .pointInCircle(from: angle * 1/4, diameter: width, margin: margin)
                .recenteredCircle(center: center, diameter: width),
            control2: CGPoint
                .pointInCircle(from: angle * 3/4, diameter: width, margin: margin)
                .recenteredCircle(center: center, diameter: width)
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
