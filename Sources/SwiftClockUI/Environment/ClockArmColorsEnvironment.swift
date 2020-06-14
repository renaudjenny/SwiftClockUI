import SwiftUI

public struct ArmColors {
    var minute: Color
    var hour: Color
}

public struct ClockArmColorsKey: EnvironmentKey {
    public static let defaultValue = ArmColors(
        minute: .primary,
        hour: .primary
    )
}

public extension EnvironmentValues {
    var clockArmColors: ArmColors {
        get { self[ClockArmColorsKey.self] }
        set { self[ClockArmColorsKey.self] = newValue }
    }
}
