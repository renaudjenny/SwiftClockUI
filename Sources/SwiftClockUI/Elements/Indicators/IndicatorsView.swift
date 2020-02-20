import SwiftUI

struct IndicatorsView: View {
    @EnvironmentObject var viewModel: AnyIndicatorsViewModel

    var body: some View {
        Group {
            if viewModel.clockStyle == .artNouveau {
                ArtNouveauIndicators()
            } else if viewModel.clockStyle == .drawing {
                DrawnIndicators()
            } else {
                ClassicIndicators()
            }
        }
    }
}

public protocol IndicatorsViewModel {
    var clockStyle: ClockStyle { get }
    var isLimitedHoursShown: Bool { get }
    var isMinuteIndicatorsShown: Bool { get }
    var isHourIndicatorsShown: Bool { get }
}

final class AnyIndicatorsViewModel: ObservableObject, IndicatorsViewModel {
    @Published private(set) var clockStyle: ClockStyle
    @Published private(set) var isLimitedHoursShown: Bool
    @Published private(set) var isMinuteIndicatorsShown: Bool
    @Published private(set) var isHourIndicatorsShown: Bool

    init<T: IndicatorsViewModel>(_ viewModel: T) {
        self.clockStyle = viewModel.clockStyle
        self.isLimitedHoursShown = viewModel.isLimitedHoursShown
        self.isMinuteIndicatorsShown = viewModel.isMinuteIndicatorsShown
        self.isHourIndicatorsShown = viewModel.isHourIndicatorsShown
    }
}

extension IndicatorsViewModel {
    func eraseToAnyIndicatorsViewModel() -> AnyIndicatorsViewModel {
        AnyIndicatorsViewModel(self)
    }
}
