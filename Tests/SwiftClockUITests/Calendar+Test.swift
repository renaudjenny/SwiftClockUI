import Foundation

extension Calendar {
    static var test: Self {
        var calendar = Self(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? calendar.timeZone
        return calendar
    }
}
