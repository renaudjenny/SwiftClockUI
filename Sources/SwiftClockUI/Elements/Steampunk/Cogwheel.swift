import SwiftUI

struct Cogwheel: Shape {
    var toothCount = 30
    var armCount = 10
    var addExtraHoles = true

    func path(in rect: CGRect) -> Path {
        let width = min(rect.width, rect.height)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let holeRadius = width * 1/8

        var path = Path()
        addCenterCircle(to: &path, center: center, radius: holeRadius)
        addArms(to: &path, rect: rect, radius: holeRadius)
        path.move(to: CGPoint(x: center.x + width/2, y: center.y))
        addTeeth(to: &path, center: center, radius: width/2)
        path.closeSubpath()
        return path
    }

    private func addCenterCircle(to path: inout Path, center: CGPoint, radius: CGFloat) {
        path.addEllipse(in: CGRect(
            x: center.x - radius/2,
            y: center.y - radius/2,
            width: radius,
            height: radius
        ))
    }

    private func addArms(to path: inout Path, rect: CGRect, radius: CGFloat) {
        let degreesByArm = 360/Double(armCount)
        let armThickness = Angle(degrees: 280 * 1/Double(armCount))
        for arm in 1...armCount {
            let arm = Double(arm)
            let angle = Angle.degrees(degreesByArm * arm)
            let startAngle = angle + .degrees(90)
            let circle = CGRect.circle(center: rect.center, radius: radius)
            let startPoint = CGPoint.inCircle(circle, for: startAngle)
            path.move(to: startPoint)
            path.addArc(center: rect.center, radius: radius, startAngle: angle, endAngle: angle - armThickness, clockwise: true)
            path.addArc(center: rect.center, radius: radius * 3, startAngle: angle - armThickness, endAngle: angle, clockwise: false)
            path.closeSubpath()
            addArmHoleIfNeeded(to: &path, rect: rect, radius: radius, startAngle: startAngle, degreesByArm: degreesByArm)
        }
    }

    private func addArmHoleIfNeeded(to path: inout Path, rect: CGRect, radius: CGFloat, startAngle: Angle, degreesByArm: Double) {
        guard addExtraHoles else { return }

        let extraHoleMargin = rect.radius * 1/5
        let extraHoleAngle = startAngle - .degrees(degreesByArm/3)
        let extraHoleRadius = radius * 1/6
        let extraHoleCenter = CGPoint
            .inCircle(rect, for: extraHoleAngle, margin: extraHoleMargin)
            .applying(.init(translationX: -extraHoleRadius/2, y: -extraHoleRadius/2))
        let extraHoleSize = CGSize(width: extraHoleRadius, height: extraHoleRadius)
        path.addEllipse(in: CGRect(origin: extraHoleCenter, size: extraHoleSize))
    }

    private func addTeeth(to path: inout Path, center: CGPoint, radius: CGFloat) {
        let degreesByTooth = 360/Double(toothCount)
        for tooth in 0..<toothCount {
            let tooth = Double(tooth)
            let angle = Angle.degrees(degreesByTooth * tooth)

            path.addArc(center: center, radius: radius, startAngle: angle, endAngle: angle + .degrees(degreesByTooth/2), clockwise: false)
            path.addArc(center: center, radius: radius * 10/11, startAngle: angle + .degrees(degreesByTooth/2), endAngle: .degrees((tooth + 1) * degreesByTooth), clockwise: false)
        }
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
            VStack(spacing: geometry.radius * -1/25) {
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
