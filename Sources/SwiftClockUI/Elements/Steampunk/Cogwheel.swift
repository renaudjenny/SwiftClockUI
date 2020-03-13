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
            let angle = Angle.degrees(degreesByArm * arm)
            let startAngle = angle + .degrees(90)
            let startPoint = CGPoint
                .pointInCircle(from: startAngle, diameter: holeDiameter)
                .recenteredCircle(center: center, diameter: holeDiameter)
            path.move(to: startPoint)
            path.addArc(center: center, radius: holeRadius, startAngle: angle, endAngle: angle - .degrees(armThickness), clockwise: true)
            path.addArc(center: center, radius: holeRadius * 3, startAngle: angle - .degrees(armThickness), endAngle: angle, clockwise: false)
            path.closeSubpath()

            let extraHoleMargin = width * 1/10
            let extraHoleAngle = startAngle - .degrees(degreesByArm/3)
            let extraHoleRadius = holeRadius * 1/6
            let extraHoleCenter = CGPoint
                .pointInCircle(from: extraHoleAngle, diameter: width, margin: extraHoleMargin)
                .recenteredCircle(center: center, diameter: width)
                .applying(.init(translationX: -extraHoleRadius/2, y: -extraHoleRadius/2))
            let extraHoleSize = CGSize(width: extraHoleRadius, height: extraHoleRadius)
            path.addEllipse(in: CGRect(origin: extraHoleCenter, size: extraHoleSize))
        }

        path.move(to: CGPoint(x: rect.maxX, y: rect.midY))

        let degreesByTooth = 360/Double(toothCount)
        for tooth in 0...toothCount {
            let tooth = Double(tooth)
            let diameter = width
            // TODO: refactor a bit here to have the same shape as arm loop
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
