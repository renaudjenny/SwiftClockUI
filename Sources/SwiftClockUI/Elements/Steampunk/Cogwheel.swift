import SwiftUI

struct Cogwheel: Shape {
    var toothCount = 30
    var armCount = 10
    var addExtraHoles = true

    func path(in rect: CGRect) -> Path {
        let width = min(rect.width, rect.height)
        let center = CGPoint(x: rect.midX, y: rect.midY)

        var path = Path()

        let holeRadius = width * 1/8
        let holeDiameter = holeRadius * 2

        path.addEllipse(in: CGRect(
            x: center.x - holeRadius/2,
            y: center.y - holeRadius/2,
            width: holeRadius,
            height: holeRadius
        ))

        let degreesByArm = 360/Double(armCount)
        let armThickness = Angle(degrees: 280 * 1/Double(armCount))
        for arm in 1...armCount {
            let arm = Double(arm)
            let angle = Angle.degrees(degreesByArm * arm)
            let startAngle = angle + .degrees(90)
            let startPoint = CGPoint
                .pointInCircle(from: startAngle, diameter: holeDiameter)
                .recenteredCircle(center: center, diameter: holeDiameter)
            path.move(to: startPoint)
            path.addArc(center: center, radius: holeRadius, startAngle: angle, endAngle: angle - armThickness, clockwise: true)
            path.addArc(center: center, radius: holeRadius * 3, startAngle: angle - armThickness, endAngle: angle, clockwise: false)
            path.closeSubpath()

            guard addExtraHoles else { continue }

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

        path.move(to: CGPoint(x: center.x + width/2, y: center.y))

        let degreesByTooth = 360/Double(toothCount)
        for tooth in 0..<toothCount {
            let tooth = Double(tooth)
            let diameter = width
            let angle = Angle.degrees(degreesByTooth * tooth)

            path.addArc(center: center, radius: diameter/2, startAngle: angle, endAngle: angle + .degrees(degreesByTooth/2), clockwise: false)
            path.addArc(center: center, radius: diameter/2.2, startAngle: angle + .degrees(degreesByTooth/2), endAngle: .degrees((tooth + 1) * degreesByTooth), clockwise: false)
        }
        path.closeSubpath()
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

struct Cogwheels_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.diameter * -1/50) {
                Cogwheel(toothCount: 10, armCount: 4, addExtraHoles: false)
                    .stroke()
                    .modifier(RotateOnAppear())
                Cogwheel(toothCount: 10, armCount: 4, addExtraHoles: false)
                    .stroke()
                    .modifier(RotateOnAppear(clockwise: false))
            }
        }.padding()
    }
}
