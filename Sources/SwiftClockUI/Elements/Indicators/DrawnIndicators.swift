import SwiftUI

struct DrawnIndicators: View {
    @Environment(\.clockConfiguration) var configuration
    @Environment(\.clockAnimationEnabled) var isAnimationEnabled
    @State private var drawStep: CGFloat = 1

    var body: some View {
        ZStack {
            if configuration.isHourIndicatorsShown {
                HoursShape(drawStep: drawStep)
            }
            if configuration.isMinuteIndicatorsShown {
                MinutesShape(drawStep: drawStep)
            }
            DrawnNumbers()
        }
        .onAppear {
            guard isAnimationEnabled else { return }
            drawStep = 0.01
            withAnimation(.default.delay(0.01)) {
                drawStep = 1
            }
        }
    }
}

private struct HoursShape: Shape {
    @Environment(\.clockRandom) var random
    var drawStep: CGFloat

    var animatableData: CGFloat {
        get { drawStep }
        set { drawStep = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        (1...12).map { hour in
            let position: CGPoint = .inCircle(
                rect,
                for: .degrees(Double(hour) * .hourInDegree),
                margin: rect.radius * 1/10
            )
            return DrawnIndicator(drawStep: drawStep, controlRatios: .init(random: random))
                .rotation(Angle(degrees: Double(hour) * .hourInDegree))
                .path(in: CGRect(
                    x: position.x - rect.radius/100,
                    y: position.y - rect.radius/20,
                    width: rect.radius/50,
                    height: rect.radius/10
                ))
        }.forEach { path.addPath($0) }
        return path
    }
}

private struct MinutesShape: Shape {
    @Environment(\.clockConfiguration) var configuration
    @Environment(\.clockRandom) var random
    var drawStep: CGFloat

    var animatableData: CGFloat {
        get { drawStep }
        set { drawStep = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        (1...60).map { minute in
            guard !isOverlapingHour(minute: minute) else { return nil }
            let position: CGPoint = .inCircle(
                rect,
                for: .degrees(Double(minute) * .minuteInDegree),
                margin: rect.radius * 1/15
            )
            return DrawnIndicator(drawStep: drawStep, controlRatios: .init(random: random))
                .rotation(Angle(degrees: Double(minute) * .minuteInDegree))
                .path(in: CGRect(
                    x: position.x - rect.radius/140,
                    y: position.y - rect.radius/40,
                    width: rect.radius/70,
                    height: rect.radius/20
                ))
        }.compactMap { $0 }.forEach { path.addPath($0) }
        return path
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
        let maxY = rect.maxY - (rect.maxY - rect.minY) * (1 - drawStep)
        let bottomCenter = CGPoint(x: rect.midX, y: maxY)
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
    private static let textFontRatio: CGFloat = 1/5

    var body: some View {
        ForEach(self.configurationHours, id: \.self) { hour in
            self.hourText(hour)
        }
    }

    private func hourText(_ hour: Int) -> some View {
        Text("\(hour)")
            .modifier(PositionInCircle(
                angle: .degrees(Double(hour) * .hourInDegree),
                marginRatio: isIndicatorsShown ? 30/100 : 20/100
            ))
            .modifier(FontProportional(ratio: Self.textFontRatio))
            .rotationEffect(random.angle() ?? .zero, anchor: .center)
            .scaleEffect(random.scale() ?? 1, anchor: .center)
    }

    private var isIndicatorsShown: Bool {
        configuration.isHourIndicatorsShown || configuration.isMinuteIndicatorsShown
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

struct DrawnIndicatorsAnimated_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    private struct Preview: View {
        @State private var drawStep: CGFloat = 1

        var body: some View {
            VStack {
                Spacer()
                ZStack {
                    Circle().stroke()
                    HoursShape(drawStep: drawStep)
                    MinutesShape(drawStep: drawStep)
                    DrawnNumbers()
                }.padding()
                Spacer()
                Slider(value: $drawStep).padding()
            }.padding()
        }
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

struct DrawnNumbers_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ZStack {
                Circle().strokeBorder()
                DrawnIndicators()
            }
            ZStack {
                Circle().strokeBorder()
                DrawnIndicators()
            }
            .environment(\.clockConfiguration, ClockConfiguration(
                isLimitedHoursShown: false,
                isMinuteIndicatorsShown: false,
                isHourIndicatorsShown: false
            ))
        }.padding()
    }
}
#endif
