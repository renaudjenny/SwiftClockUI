import SwiftUI

struct DrawnIndicators: View {
    @Environment(\.clockConfiguration) var configuration

    var body: some View {
        ZStack {
            if configuration.isHourIndicatorsShown {
                Hours()
            }
            if configuration.isMinuteIndicatorsShown {
                Minutes()
            }
            DrawnNumbers()
        }
    }
}

private struct Hours: View {
    @Environment(\.clockIsAnimationEnabled) var isAnimationEnabled
    @Environment(\.clockRandom) var random
    private static let marginRatio: CGFloat = 1/10
    @State private var drawStep: CGFloat = 1

    var body: some View {
        ForEach(1...12, id: \.self) { hour in
            DrawnIndicator(drawStep: self.drawStep, controlRatios: .init(random: self.random))
                .rotation(Angle(degrees: Double(hour) * .hourInDegree))
                .modifier(PositionInCircle(
                    angle: .degrees(Double(hour) * .hourInDegree),
                    marginRatio: Self.marginRatio
                ))
                .onAppear {
                    guard self.isAnimationEnabled else { return }
                    withAnimation {
                        self.drawStep = 0.1
                    }
                    withAnimation(Animation.easeInOut.delay(0.1)) {
                        self.drawStep = 1
                    }
                }
        }
    }
}

private struct Minutes: View {
    @Environment(\.clockConfiguration) var configuration
    @Environment(\.clockIsAnimationEnabled) var isAnimationEnabled
    @Environment(\.clockRandom) var random
    private static let marginRatio: CGFloat = 1/15
    @State private var drawStep: CGFloat = 1

    var body: some View {
        ForEach(1...60, id: \.self) { minute in
            Group {
                if self.isOverlapingHour(minute: minute) {
                    EmptyView()
                } else {
                    self.indicator(minute: minute)
                }
            }
        }
    }

    private func indicator(minute: Int) -> some View {
        Group {
            if self.isOverlapingHour(minute: minute) {
                EmptyView()
            } else {
                DrawnIndicator(drawStep: self.drawStep, controlRatios: .init(random: self.random))
                    .scale(2/3)
                    .rotation(Angle(degrees: Double(minute) * .minuteInDegree))
                    .modifier(PositionInCircle(
                        angle: .degrees(Double(minute) * .minuteInDegree),
                        marginRatio: Self.marginRatio
                    ))
                    .onAppear {
                        guard self.isAnimationEnabled else { return }
                        withAnimation(.easeInOut) {
                            self.drawStep = 0.1
                        }
                        withAnimation(.easeInOut) {
                            self.drawStep = 1
                        }
                    }
            }
        }
    }

    private func isOverlapingHour(minute: Int) -> Bool {
        guard configuration.isHourIndicatorsShown else { return false }
        return minute == 0 || minute % 5 == 0
    }
}

private struct DrawnIndicator: Shape {
    var drawStep: CGFloat
    let controlRatios: Random.ControlRatio

    var animatableData: CGFloat {
        get { self.drawStep }
        set { self.drawStep = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let thickness = rect.radius/50
        let height = thickness * 2
        let width = thickness
        let bottomCenter = CGPoint(x: rect.midX, y: rect.midY + height)
        let bottomRight = CGPoint(
            x: bottomCenter.x + width,
            y: bottomCenter.y
        )
        let topCenter = CGPoint(
            x: rect.midX,
            y: rect.midY - height + ((1 - drawStep) * height)
        )
        let topLeft = CGPoint(
            x: topCenter.x - width,
            y: topCenter.y
        )

        path.move(to: bottomRight)

        path.addArc(
            center: bottomCenter,
            radius: thickness * drawStep,
            startAngle: .zero,
            endAngle: .degrees(180),
            clockwise: false
        )

        let controlLeft = CGPoint(
            x: rect.midX + width * self.controlRatios.leftX,
            y: rect.midY + height * self.controlRatios.leftY
        )
        path.addQuadCurve(to: topLeft, control: controlLeft)

        path.addArc(
            center: topCenter,
            radius: thickness * drawStep,
            startAngle: .degrees(180),
            endAngle: .zero,
            clockwise: false
        )

        let controlRight = CGPoint(
            x: rect.midX + width * self.controlRatios.rightX,
            y: rect.midY + height * self.controlRatios.rightY
        )
        path.addQuadCurve(to: bottomRight, control: controlRight)

        return path
    }
}

struct DrawnNumbers: View {
    @Environment(\.clockConfiguration) var configuration
    @Environment(\.clockRandom) var random
    private static let hours = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    private static let limitedHours = [12, 3, 6, 9]
    private static let marginRatio: CGFloat = 2/7
    private static let textFontRatio: CGFloat = 1/5

    var body: some View {
        ForEach(self.configurationHours, id: \.self) { hour in
            self.hourText(hour)
        }
    }

    private func hourText(_ hour: Int) -> some View {
        Text("\(hour)")
            .modifier(PositionInCircle(
                angle: .degrees(Double(hour) * .hourInDegree), marginRatio: self.marginRatio
            ))
            .modifier(FontProportional(ratio: Self.textFontRatio))
            .rotationEffect(random.angle() ?? .zero, anchor: .center)
            .scaleEffect(random.scale() ?? 1, anchor: .center)
    }

    private var marginRatio: CGFloat {
        configuration.isHourIndicatorsShown || configuration.isMinuteIndicatorsShown
            ? Self.marginRatio
            : Self.marginRatio/2
    }

    private var configurationHours: [Int] {
        configuration.isLimitedHoursShown ? Self.limitedHours : Self.hours
    }
}

#if DEBUG
struct DrawnIndicators_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            DrawnIndicators()
                .environment(\.clockIsAnimationEnabled, false)
        }.padding()
    }
}

struct DrawnIndicatorsAnimatedElements_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    private struct Preview: View {
        @State private var drawStep: CGFloat = 1

        var body: some View {
            VStack {
                DrawnIndicator(drawStep: drawStep, controlRatios: .init(random: .fixed))
                Slider(value: $drawStep)
            }.padding()
        }
    }
}
#endif
