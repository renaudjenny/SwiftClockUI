import SwiftUI

public struct ClockDateKey: EnvironmentKey {
    public static let defaultValue: Binding<Date> = .constant(Date())
}

public extension EnvironmentValues {
    var clockDate: Binding<Date> {
        get { self[ClockDateKey.self] }
        set { self[ClockDateKey.self] = newValue }
    }
}
