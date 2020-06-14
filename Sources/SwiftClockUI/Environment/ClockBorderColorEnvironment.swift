import SwiftUI

public struct ClockBorderColorArmKey: EnvironmentKey {
    public static let defaultValue: Color = .primary
}

public extension EnvironmentValues {
    var clockBorderColor: Color {
        get { self[ClockBorderColorArmKey.self] }
        set { self[ClockBorderColorArmKey.self] = newValue }
    }
}
