import SwiftUI

struct ClockFaceShownKey: EnvironmentKey {
    public static let defaultValue = false
}

extension EnvironmentValues {
    var clockFaceShown: Bool {
        get { self[ClockFaceShownKey.self] }
        set { self[ClockFaceShownKey.self] = newValue }
    }
}
