import SwiftUI

struct Cogwheel: Shape {
    var toothCount = 30
    var armCount = 10
    var addExtraHoles = true

    func path(in rect: CGRect) -> Path {
        var path = Path()
        addCenterCircle(to: &path, rect: rect)
        addArms(to: &path, rect: rect)
        path.move(to: CGPoint(x: rect.midX + rect.radius, y: rect.midY))
        addTeeth(to: &path, rect: rect)
        path.closeSubpath()
        return path
    }

    private func addCenterCircle(to path: inout Path, rect: CGRect) {
        let radius = rect.radius * 1/4
        path.addEllipse(in: CGRect(
            x: rect.midX - radius/2,
            y: rect.midY - radius/2,
            width: radius,
            height: radius
        ))
    }

    private func addArms(to path: inout Path, rect: CGRect) {
        let radius = rect.radius * 1/4
        let degreesByArm = 360/Double(armCount)
        let armThickness = Angle(degrees: 280 * 1/Double(armCount))
        for arm in 1...armCount {
            let arm = Double(arm)
            let angle = Angle.degrees(degreesByArm * arm)
            let startAngle = angle + .degrees(90)
            let circle = CGRect.circle(center: rect.center, radius: radius)
            let startPoint = CGPoint.inCircle(circle, for: startAngle)
            path.move(to: startPoint)
            path.addArc(
                center: rect.center,
                radius: radius,
                startAngle: angle,
                endAngle: angle - armThickness,
                clockwise: true
            )
            path.addArc(
                center: rect.center,
                radius: radius * 3,
                startAngle: angle - armThickness,
                endAngle: angle,
                clockwise: false
            )
            path.closeSubpath()
            addArmHoleIfNeeded(to: &path, rect: rect, startAngle: startAngle)
        }
    }

    private func addArmHoleIfNeeded(to path: inout Path, rect: CGRect, startAngle: Angle) {
        guard addExtraHoles else { return }

        let degreesByArm = 360/Double(armCount)
        let extraHoleMargin = rect.radius * 1/5
        let extraHoleAngle = startAngle - .degrees(degreesByArm/3)
        let extraHoleRadius = rect.radius * 1/24
        let extraHoleCenter = CGPoint
            .inCircle(rect, for: extraHoleAngle, margin: extraHoleMargin)
            .applying(.init(translationX: -extraHoleRadius/2, y: -extraHoleRadius/2))
        let extraHoleSize = CGSize(width: extraHoleRadius, height: extraHoleRadius)
        path.addEllipse(in: CGRect(origin: extraHoleCenter, size: extraHoleSize))
    }

    private func addTeeth(to path: inout Path, rect: CGRect) {
        let degreesByTooth = 360/Double(toothCount)
        for tooth in 0..<toothCount {
            let tooth = Double(tooth)
            let angle = Angle.degrees(degreesByTooth * tooth)

            path.addArc(
                center: rect.center,
                radius: rect.radius,
                startAngle: angle,
                endAngle: angle + .degrees(degreesByTooth/2),
                clockwise: false
            )
            path.addArc(
                center: rect.center,
                radius: rect.radius * 10/11,
                startAngle: angle + .degrees(degreesByTooth/2),
                endAngle: .degrees((tooth + 1) * degreesByTooth),
                clockwise: false
            )
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
        Preview().padding()
    }

    private struct Preview: View {
        var body: some View {
            GeometryReader(content: content)
        }

        private func content(geometry: GeometryProxy) -> some View {
            VStack(spacing: geometry.radius * -1/25) {
                Cogwheel(toothCount: 10, armCount: 4, addExtraHoles: false)
                    .stroke()
                    .modifier(RotateOnAppear())
                Cogwheel(toothCount: 10, armCount: 4, addExtraHoles: false)
                    .stroke()
                    .modifier(RotateOnAppear(clockwise: false))
            }
        }
    }
}
