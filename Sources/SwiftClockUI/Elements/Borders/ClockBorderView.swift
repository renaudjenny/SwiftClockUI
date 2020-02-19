import SwiftUI

struct ClockBorderView: View {
    @EnvironmentObject var viewModel: AnyClockBorderViewModel

    var body: some View {
        Group {
            if viewModel.clockStyle == .artNouveau {
                ArtNouveauClockBorder()
            } else if viewModel.clockStyle == .drawing {
                DrawnClockBorder()
            } else {
                ClassicClockBorder()
            }
        }
    }
}

protocol ClockBorderViewModel {
    var clockStyle: ClockStyle { get set }
}

final class AnyClockBorderViewModel: ObservableObject {
    @Published private(set) var clockStyle: ClockStyle

    init<T: ClockBorderViewModel>(_ viewModel: T) {
        self.clockStyle = viewModel.clockStyle
    }
}

extension ClockBorderViewModel {
    func eraseToAnyClockBorderViewModel() -> AnyClockBorderViewModel {
        AnyClockBorderViewModel(self)
    }
}
