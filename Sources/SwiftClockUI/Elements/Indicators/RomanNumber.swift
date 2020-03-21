import SwiftUI

enum RomanNumber {
    static let numbers = ["XII", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI"]
    static let limitedNumbers = ["XII", "III", "VI", "IX"]

    static func numbers(configuration: ClockConfiguration) -> [String] {
        configuration.isLimitedHoursShown ? Self.limitedNumbers : Self.numbers
    }

    static func angle(for romanNumber: String) -> Angle {
        guard let index = Self.numbers.firstIndex(of: romanNumber) else { return .zero }
        return Angle(degrees: Double(index) * .hourInDegree)
    }
}
