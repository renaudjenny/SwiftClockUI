import SwiftUI

struct DrawnArm: View {
    @Environment(\.clockRandom) var random
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    private static let widthRatio: CGFloat = 1/20
    let type: ArmType
    @State private var drawStep: CGFloat = 1

    var body: some View {
        DrawnArmShape(type: type, drawStep: drawStep, controlRatios: .init(random: self.random))
            .onAppear {
                guard !reduceMotion else { return }
                self.drawStep = 0.01
                withAnimation(Animation.easeInOut.delay(0.01)) {
                    self.drawStep = 1
                }
            }
    }
}

private struct DrawnArmShape: Shape {
    private static let thicknessRatio: CGFloat = 1/30
    let type: ArmType
    var drawStep: CGFloat
    let controlRatios: Random.ControlRatio

    var animatableData: CGFloat {
        get { self.drawStep }
        set { self.drawStep = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let thickness = rect.radius * Self.thicknessRatio * type.ratio.lineWidth
        let margin = rect.radius * type.ratio.margin

        path.addArc(
            center: rect.center,
            radius: thickness,
            startAngle: .degrees(90),
            endAngle: .zero,
            clockwise: true
        )

        let top = CGPoint(
            x: rect.midX,
            y: rect.midY - rect.radius * drawStep + margin * drawStep
        )

        let control1 = CGPoint(
            x: rect.midX + thickness - thickness * 2 * controlRatios.leftX,
            y: top.y + rect.radius * drawStep * controlRatios.leftY
        )
        let control2 = CGPoint(
            x: rect.midX + thickness + thickness * 2 * controlRatios.leftX,
            y: top.y + rect.radius * drawStep * controlRatios.leftY/2
        )

        path.addCurve(
            to: CGPoint(x: rect.midX + thickness, y: top.y),
            control1: control1,
            control2: control2
        )

        path.addArc(
            center: top,
            radius: thickness,
            startAngle: .zero,
            endAngle: .degrees(270),
            clockwise: true
        )

        path.addVerticalMirror(in: rect)

        return path
    }
}

#if DEBUG
struct DrawnArm_Previews: PreviewProvider {
    private struct Preview: View {
        @State private var redo: Bool = true

        var body: some View {
            VStack {
                ZStack {
                    Circle().stroke()
                    if redo {
                        DrawnArm(type: .minute)
                    }
                }
                .padding()

                Button("Redo animation") {
                    redo = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        redo = true
                    }
                }
            }
        }
    }

    static var previews: some View {
        Preview()
    }
}

struct DrawnArmAnimated_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    private struct Preview: View {
        @State private var drawStep: CGFloat = 1

        var body: some View {
            VStack {
                ZStack {
                    Circle().stroke()
                    DrawnArmShape(
                        type: .minute,
                        drawStep: drawStep,
                        controlRatios: .init(random: .fixed)
                    )
                }
                Slider(value: $drawStep)
            }.padding()
        }
    }
}
#endif
