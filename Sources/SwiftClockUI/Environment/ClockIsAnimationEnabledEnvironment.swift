import SwiftUI

public struct ClockIsAnimationEnabledEnvironmentKey: EnvironmentKey {
    public static let defaultValue: Bool = true
}

public extension EnvironmentValues {
    @available(*, deprecated, message: "Not used anymore. You can safely remove it.")
    var clockIsAnimationEnabled: Bool {
        get { self[ClockIsAnimationEnabledEnvironmentKey.self] }
        set { self[ClockIsAnimationEnabledEnvironmentKey.self] = newValue }
    }
}
