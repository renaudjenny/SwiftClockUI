import SwiftUI

struct ClassicIndicators: View {
    @EnvironmentObject var viewModel: AnyIndicatorsViewModel
    private static let marginRatio: CGFloat = 1/7

    var body: some View {
        ZStack(alignment: .center) {
            HourTexts(marginRatio: Self.marginRatio)
            if viewModel.isHourIndicatorsShown {
                HourIndicators(marginRatio: Self.marginRatio)
            }
            if viewModel.isMinuteIndicatorsShown {
                MinuteIndicators(marginRatio: Self.marginRatio)
            }
        }
        .modifier(ScaleUpOnAppear())
    }
}

private struct HourTexts: View {
    @EnvironmentObject var viewModel: AnyIndicatorsViewModel
    private static let hours = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    private static let limitedHours = [12, 3, 6, 9]
    private static let fontSizeRatio: CGFloat = 1/10
    let marginRatio: CGFloat

    var body: some View {
        ForEach(self.configurationHours, id: \.self) { hour in
            Text("\(hour)")
                .modifier(FontProportional(ratio: Self.fontSizeRatio))
                .modifier(PositionInCircle(
                    angle: .degrees(Double(hour) * .hourInDegree),
                    marginRatio: self.dynamicMarginRatio
                ))
        }
    }

    private var configurationHours: [Int] {
        viewModel.isLimitedHoursShown ? Self.limitedHours : Self.hours
    }

    private var dynamicMarginRatio: CGFloat {
        viewModel.isMinuteIndicatorsShown || viewModel.isHourIndicatorsShown
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
                    .frame(width: geometry.localDiameter * Self.hourDotRatio)
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
                    .frame(width: geometry.localDiameter * Self.minuteDotRatio)
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
        }
        .padding()
        .modifier(PreviewEnvironmentObject())
    }
}
#endif
