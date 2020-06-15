import SwiftUI

public struct ClockArmColors {
    var minute: Color
    var hour: Color

    public init(minute: Color, hour: Color) {
        self.minute = minute
        self.hour = hour
    }
}

public struct ClockArmColorsKey: EnvironmentKey {
    public static let defaultValue = ClockArmColors(
        minute: .primary,
        hour: .primary
    )
}

public extension EnvironmentValues {
    var clockArmColors: ClockArmColors {
        get { self[ClockArmColorsKey.self] }
        set { self[ClockArmColorsKey.self] = newValue }
    }
}
