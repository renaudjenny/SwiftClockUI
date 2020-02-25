import SwiftUI

public struct ClockConfiguration {
    public var isLimitedHoursShown = false
    public var isMinuteIndicatorsShown = true
    public var isHourIndicatorsShown = true
    public var isAnimationEnabled = true

    public init(
        isLimitedHoursShown: Bool = false,
        isMinuteIndicatorsShown: Bool = true,
        isHourIndicatorsShown: Bool = true,
        isAnimationEnabled: Bool = true
    ) {
        self.isLimitedHoursShown = isLimitedHoursShown
        self.isMinuteIndicatorsShown = isMinuteIndicatorsShown
        self.isHourIndicatorsShown = isHourIndicatorsShown
        self.isAnimationEnabled = isAnimationEnabled
    }
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
