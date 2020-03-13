import SwiftUI

struct Cogwheel: Shape {
    var toothCount: Int = 30
    var armCount: Int = 10

    func path(in rect: CGRect) -> Path {
        let width = min(rect.width, rect.height)
        let center = CGPoint(x: rect.midX, y: rect.midY)

        var path = Path()

        let holeRadius = width * 1/8
        let holeDiameter = holeRadius * 2

        path.addEllipse(in: CGRect(
            x: rect.midX - holeRadius/2,
            y: rect.midY - holeRadius/2,
            width: holeRadius,
            height: holeRadius
        ))

        let armThickness = Double(width) * 4/5/Double(armCount)

        let degreesByArm = 360/Double(armCount)
        for arm in 1...armCount {
            let arm = Double(arm)
            let startPoint = CGPoint
                .pointInCircle(from: .degrees(degreesByArm * arm + 90), diameter: holeDiameter)
                .recenteredCircle(center: center, diameter: holeDiameter)
            path.move(to: startPoint)
            path.addArc(center: center, radius: holeRadius, startAngle: .degrees(arm * degreesByArm), endAngle: .degrees(arm * degreesByArm - armThickness), clockwise: true)
            path.addArc(center: center, radius: holeRadius * 3, startAngle: .degrees(arm * degreesByArm - armThickness), endAngle: .degrees(arm * degreesByArm), clockwise: false)
            path.closeSubpath()
        }

        path.move(to: CGPoint(x: rect.maxX, y: rect.midY))

        let degreesByTooth = 360/Double(toothCount)
        for tooth in 0...toothCount {
            let tooth = Double(tooth)
            let diameter = width
            path.addArc(center: center, radius: diameter/2, startAngle: .degrees(tooth * degreesByTooth), endAngle: .degrees(tooth * degreesByTooth + degreesByTooth/2), clockwise: false)
            path.addArc(center: center, radius: diameter/2.2, startAngle: .degrees(tooth * degreesByTooth + degreesByTooth/2), endAngle: .degrees((tooth + 1) * degreesByTooth), clockwise: false)
        }

        return path
    }
}

struct Cogwheel_Previews: PreviewProvider {
    static var previews: some View {
        Cogwheel()
            .stroke()
            .padding()
    }
}
