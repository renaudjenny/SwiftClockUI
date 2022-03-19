import SwiftUI

struct ClockAnimationEnabledKey: EnvironmentKey {
    public static let defaultValue: Bool = !EnvironmentValues().accessibilityReduceMotion
}

extension EnvironmentValues {
    var clockAnimationEnabled: Bool {
        get { self[ClockAnimationEnabledKey.self] }
        set { self[ClockAnimationEnabledKey.self] = newValue }
    }
}
