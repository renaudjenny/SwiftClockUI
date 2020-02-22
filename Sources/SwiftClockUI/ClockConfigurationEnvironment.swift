import SwiftUI

public struct ClockConfiguration {
    var isLimitedHoursShown = false
    var isMinuteIndicatorsShown = true
    var isHourIndicatorsShown = true
}

public struct ClockConfigurationEnvironmentKey: EnvironmentKey {
    public static let defaultValue: ClockConfiguration = ClockConfiguration()
}

public extension EnvironmentValues {
    var clockConfiguration: ClockConfiguration {
        get { self[ClockConfigurationEnvironmentKey.self] }
        set { self[ClockConfigurationEnvironmentKey.self] = newValue }
    }
}
