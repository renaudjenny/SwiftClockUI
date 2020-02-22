import SwiftUI

public typealias ClockEnvironmentViewModel = ClockViewModel & ClockBorderViewModel & IndicatorsViewModel
    & ClockFaceViewModel & ArmViewModel

public struct ClockEnvironmentObject: ViewModifier {
    let viewModel: ClockEnvironmentViewModel

    public init(viewModel: ClockEnvironmentViewModel) {
        self.viewModel = viewModel
    }

    public func body(content: Content) -> some View {
        content
            .environmentObject(viewModel.eraseToAnyClockViewModel())
            .environmentObject(viewModel.eraseToAnyArmViewModel())
            .environmentObject(viewModel.eraseToAnyClockFaceViewModel())
            .environmentObject(viewModel.eraseToAnyIndicatorsViewModel())
            .environmentObject(viewModel.eraseToAnyClockBorderViewModel())
    }
}

public struct ClockDateKey: EnvironmentKey {
    public static let defaultValue: Binding<Date> = .constant(Date())
}

public extension EnvironmentValues {
    var clockDate: Binding<Date> {
        get { self[ClockDateKey.self] }
        set { self[ClockDateKey.self] = newValue }
    }
}

enum App { }

#if DEBUG
extension App {
    final class PreviewViewModel: ObservableObject, ClockEnvironmentViewModel {
        @Published var clockStyle: ClockStyle = .classic
        @Published var hourAngle: Angle = .zero
        @Published var minuteAngle: Angle = .zero
        @Published var isClockFaceShown = false
        @Published var isLimitedHoursShown = false
        @Published var isHourIndicatorsShown = true
        @Published var isMinuteIndicatorsShown = true

        var showClockFace: (() -> Void)?
        var delayClockFaceHidding: (() -> Void)?
    }

    static func previewViewModel(_ modifyViewModel: (inout PreviewViewModel) -> Void) -> PreviewViewModel {
        var viewModel = PreviewViewModel()
        modifyViewModel(&viewModel)
        return viewModel
    }
}

struct PreviewEnvironmentObject: ViewModifier {
    let modifyViewModel: (inout App.PreviewViewModel) -> Void

    init(_ modifyViewModel: @escaping (inout App.PreviewViewModel) -> Void = { _ in }) {
        self.modifyViewModel = modifyViewModel
    }

    func body(content: Content) -> some View {
        content
            .modifier(ClockEnvironmentObject(viewModel: App.previewViewModel(modifyViewModel)))
    }
}
#endif
