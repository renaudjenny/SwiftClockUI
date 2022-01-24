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
    @Environment(\.clockRandom) var random
    @State private var drawStep: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            ForEach(1...12, id: \.self) { hour in
                DrawnIndicator(drawStep: self.drawStep, controlRatios: .init(random: self.random))
                    .rotation(Angle(degrees: Double(hour) * .hourInDegree))
                    .frame(width: geometry.radius/50, height: geometry.radius/10)
                    .modifier(PositionInCircle(
                        angle: .degrees(Double(hour) * .hourInDegree),
                        marginRatio: 1/10
                    ))
                    .onAppear {
                        withAnimation(.default.delay(0.01)) {
                            self.drawStep = 1
                        }
                    }
            }
        }
    }
}

private struct Minutes: View {
    @Environment(\.clockConfiguration) var configuration
    @Environment(\.clockRandom) var random
    @State private var drawStep: CGFloat = 0

    var body: some View {
        ForEach(1...60, id: \.self) { minute in
            Group {
                if self.isOverlapingHour(minute: minute) {
                    EmptyView()
                } else {
                    self.indicator(minute: minute)
                }
            }
            .onAppear {
                withAnimation(.default.delay(0.01)) {
                    self.drawStep = 1
                }
            }
        }
    }

    private func indicator(minute: Int) -> some View {
        Group {
            if self.isOverlapingHour(minute: minute) {
                EmptyView()
            } else {
                GeometryReader { geometry in
                    DrawnIndicator(drawStep: drawStep, controlRatios: .init(random: random))
                        .rotation(Angle(degrees: Double(minute) * .minuteInDegree))
                        .frame(width: geometry.circle.radius/70, height: geometry.circle.radius/20)
                        .modifier(PositionInCircle(
                            angle: .degrees(Double(minute) * .minuteInDegree),
                            marginRatio: 1/15
                        ))
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
        let thickness = rect.width
        let bottomCenter = CGPoint(x: rect.midX, y: rect.maxY  - (rect.maxY * (1 - drawStep)))
        let bottomRight = CGPoint(
            x: bottomCenter.x + thickness,
            y: bottomCenter.y
        )
        let topCenter = CGPoint(
            x: rect.midX,
            y: rect.minY
        )
        let topLeft = CGPoint(
            x: topCenter.x - thickness,
            y: topCenter.y
        )

        path.move(to: bottomRight)

        path.addArc(
            center: bottomCenter,
            radius: thickness,
            startAngle: .zero,
            endAngle: .degrees(180),
            clockwise: false
        )

        let controlLeft = CGPoint(
            x: rect.midX + thickness * self.controlRatios.leftX,
            y: topCenter.y + thickness * 2 * self.controlRatios.leftY
        )
        path.addQuadCurve(to: topLeft, control: controlLeft)

        path.addArc(
            center: topCenter,
            radius: thickness,
            startAngle: .degrees(180),
            endAngle: .zero,
            clockwise: false
        )

        let controlRight = CGPoint(
            x: rect.midX + thickness * self.controlRatios.rightX,
            y: topCenter.y + thickness * 2 * self.controlRatios.rightY
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
                Spacer()
                DrawnIndicator(drawStep: drawStep, controlRatios: .init(random: .fixed))
                    .frame(width: 10, height: 200)
                Spacer()
                Slider(value: $drawStep).padding()
            }.padding()
        }
    }
}
#endif
