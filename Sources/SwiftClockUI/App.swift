import SwiftUI

// TODO: move to its own file
public struct ClockDateKey: EnvironmentKey {
    public static let defaultValue: Binding<Date> = .constant(Date())
}

public extension EnvironmentValues {
    var clockDate: Binding<Date> {
        get { self[ClockDateKey.self] }
        set { self[ClockDateKey.self] = newValue }
    }
}

// TODO: move to its own file
public struct ClockStyleKey: EnvironmentKey {
    public static let defaultValue: ClockStyle = .classic
}

public extension EnvironmentValues {
    var clockStyle: ClockStyle {
        get { self[ClockStyleKey.self] }
        set { self[ClockStyleKey.self] = newValue }
    }
}
