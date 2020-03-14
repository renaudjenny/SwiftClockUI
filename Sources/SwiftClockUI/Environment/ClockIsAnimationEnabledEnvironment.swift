import SwiftUI

public struct ClockIsAnimationEnabledEnvironmentKey: EnvironmentKey {
    public static let defaultValue: Bool = true
}

public extension EnvironmentValues {
    var clockIsAnimationEnabled: Bool {
        get { self[ClockIsAnimationEnabledEnvironmentKey.self] }
        set { self[ClockIsAnimationEnabledEnvironmentKey.self] = newValue }
    }
}
