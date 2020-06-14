import SwiftUI

public struct ClockIndicatorsColorArmKey: EnvironmentKey {
    public static let defaultValue: Color = .primary
}

public extension EnvironmentValues {
    var clockIndicatorsColor: Color {
        get { self[ClockIndicatorsColorArmKey.self] }
        set { self[ClockIndicatorsColorArmKey.self] = newValue }
    }
}
