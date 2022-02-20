import SwiftUI

struct Cogwheel: Shape, Animatable {
    private(set) var toothCount = 30
    private(set) var armCount = 10
    private(set) var addExtraHoles = true
    private(set) var angle: Angle

    var animatableData: Double {
        get { angle.radians }
        set { angle.radians = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        addCenterCircle(to: &path, rect: rect)
        addArms(to: &path, rect: rect)
        path.move(to: CGPoint(x: rect.midX + rect.radius, y: rect.midY))
        addTeeth(to: &path, rect: rect)
        path.closeSubpath()
        return path.applying(CGAffineTransform(
            a: cos(angle.radians), b: sin(angle.radians),
            c: -sin(angle.radians), d: cos(angle.radians),
            tx: rect.midX - rect.midX * cos(angle.radians) + rect.midY * sin(angle.radians),
            ty: rect.midY - rect.midX * sin(angle.radians) - rect.midY * cos(angle.radians)
        ))
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

struct Cogwheels: Shape, Animatable {
    struct Data {
        private(set) var cogwheel: (toothCount: Int, armCount: Int)
        private(set) var relativeOffset: (x: Double, y: Double)
        private(set) var scale: Double
        private(set) var isClockwise: Bool = true
    }

    private(set) var data: [Data]
    private(set) var angle: Angle

    var animatableData: Double {
        get { angle.radians }
        set { angle.radians = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for datum in data {
            path.addPath(
                Cogwheel(
                    toothCount: datum.cogwheel.toothCount,
                    armCount: datum.cogwheel.armCount,
                    addExtraHoles: false,
                    angle: datum.isClockwise ? angle : -angle
                )
                    .scale(datum.scale)
                    .path(in: rect.offsetBy(
                        dx: datum.relativeOffset.x * rect.circle.maxX - rect.circle.midX,
                        dy: datum.relativeOffset.y * rect.circle.maxY - rect.circle.midY
                    ))
            )
        }
        return path
    }
}

struct Cogwheel_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    private struct Preview: View {
        @State private var angle: Angle = .zero

        var body: some View {
            VStack {
                Cogwheel(angle: angle).stroke().padding()
                Spacer()
                Text(String(format: "Degrees: %.f", angle.degrees))
                Slider(value: $angle.degrees, in: 0...360).padding()
            }
        }
    }
}

struct Cogwheels_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    private struct Preview: View {
        @State private var angle: Angle = .zero

        var body: some View {
            VStack {
                Cogwheels(
                    data: [
                        .init(
                            cogwheel: (toothCount: 10, armCount: 4),
                            relativeOffset: (x: 1/2, y: 26/100),
                            scale: 1/2,
                            isClockwise: true
                        ),
                        .init(
                            cogwheel: (toothCount: 10, armCount: 4),
                            relativeOffset: (x: 1/2, y: 74/100),
                            scale: 1/2,
                            isClockwise: false
                        )
                    ],
                    angle: angle
                ).stroke()
                Spacer()
                Text(String(format: "Degrees: %.f", angle.degrees)).animation(nil)
                Slider(value: $angle.degrees, in: 0...360).padding()
                Button("Start animation") {
                    guard angle == .zero else { return }
                    withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                        angle += .fullRound
                    }
                }.padding()
            }
        }
    }
}
