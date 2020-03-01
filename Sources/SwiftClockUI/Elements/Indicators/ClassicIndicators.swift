import SwiftUI

struct ClassicIndicators: View {
    @Environment(\.clockConfiguration) var configuration
    private static let marginRatio: CGFloat = 1/7

    var body: some View {
        ZStack(alignment: .center) {
            HourTexts(marginRatio: Self.marginRatio)
            if configuration.isHourIndicatorsShown {
                HourIndicators(marginRatio: Self.marginRatio)
            }
            if configuration.isMinuteIndicatorsShown {
                MinuteIndicators(marginRatio: Self.marginRatio)
            }
        }
        .aspectRatio(1/1, contentMode: .fit)
        .modifier(ScaleUpOnAppear())
    }
}

private struct HourTexts: View {
    @Environment(\.clockConfiguration) var configuration
    private static let hours = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    private static let limitedHours = [12, 3, 6, 9]
    private static let textScaleRatio: CGFloat = 1/160
    let marginRatio: CGFloat

    var body: some View {
        ForEach(self.configurationHours, id: \.self) { hour in
            Text("\(hour)")
                .modifier(ScaleProportional(ratio: Self.textScaleRatio))
                .modifier(PositionInCircle(
                    angle: .degrees(Double(hour) * .hourInDegree),
                    marginRatio: self.dynamicMarginRatio
                ))
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
    private static let hourDotRatio: CGFloat = 1/35
    let marginRatio: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ForEach(1..<13) { hour in
                Circle()
                    .frame(width: geometry.diameter * Self.hourDotRatio)
                    .modifier(PositionInCircle(
                        angle: .degrees(Double(hour) * .hourInDegree),
                        marginRatio: self.marginRatio/3
                    ))
            }
        }
    }
}

private struct MinuteIndicators: View {
    private static let minuteDotRatio: CGFloat = 1/70
    let marginRatio: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ForEach(1..<61) { minute in
                Circle()
                    .frame(width: geometry.diameter * Self.minuteDotRatio)
                    .modifier(PositionInCircle(
                        angle: .degrees(Double(minute) * .minuteInDegree),
                        marginRatio: self.marginRatio/3
                    ))
            }
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
