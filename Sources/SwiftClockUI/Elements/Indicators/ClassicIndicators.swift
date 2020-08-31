import SwiftUI

struct ClassicIndicators: View {
    @Environment(\.clockConfiguration) var configuration
    private static let marginRatio: CGFloat = 2/7

    var body: some View {
        ZStack {
            HourTexts(marginRatio: Self.marginRatio)
            if configuration.isHourIndicatorsShown {
                HourIndicators(marginRatio: Self.marginRatio)
            }
            if configuration.isMinuteIndicatorsShown {
                MinuteIndicators(marginRatio: Self.marginRatio)
            }
        }
        .modifier(ScaleUpOnAppear())
    }
}

private struct HourTexts: View {
    @Environment(\.clockConfiguration) var configuration
    private static let hours = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    private static let limitedHours = [12, 3, 6, 9]
    private static let textFontRatio: CGFloat = 1/5
    let marginRatio: CGFloat

    var body: some View {
        ForEach(self.configurationHours, id: \.self) { hour in
            Text("\(hour)")
                .modifier(PositionInCircle(
                    angle: .degrees(Double(hour) * .hourInDegree),
                    marginRatio: self.dynamicMarginRatio
                ))
                .modifier(FontProportional(ratio: Self.textFontRatio))
        }
    }

    private var configurationHours: [Int] {
        configuration.isLimitedHoursShown ? Self.limitedHours : Self.hours
    }

    private var dynamicMarginRatio: CGFloat {
        configuration.isMinuteIndicatorsShown || configuration.isHourIndicatorsShown
            ? self.marginRatio
            : self.marginRatio/2
    }
}

private struct HourIndicators: View {
    private static let hourDotRatio: CGFloat = 2/35
    let marginRatio: CGFloat

    var body: some View {
        GeometryReader(content: content)
    }

    private func content(geometry: GeometryProxy) -> some View {
        ForEach(1..<13) { hour in
            Circle()
                .frame(width: geometry.radius * Self.hourDotRatio)
                .modifier(PositionInCircle(
                    angle: .degrees(Double(hour) * .hourInDegree),
                    marginRatio: self.marginRatio/3
                ))
        }
    }
}

private struct MinuteIndicators: View {
    private static let minuteDotRatio: CGFloat = 1/35
    let marginRatio: CGFloat

    var body: some View {
        GeometryReader(content: content)
    }

    private func content(geometry: GeometryProxy) -> some View {
        ForEach(1..<61) { minute in
            Circle()
                .frame(width: geometry.radius * Self.minuteDotRatio)
                .modifier(PositionInCircle(
                    angle: .degrees(Double(minute) * .minuteInDegree),
                    marginRatio: self.marginRatio/3
                ))
        }
    }
}

#if DEBUG
struct ClassicIndicators_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ClassicIndicators()
            Circle().stroke()
        }.padding()
    }
}
#endif
