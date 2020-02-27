import SwiftUI

enum ArmType {
    case hour
    case minute

    typealias Ratio = (lineWidth: CGFloat, margin: CGFloat)
    private static let hourRatio: Ratio = (lineWidth: 1/2, margin: 2/5)
    private static let minuteRatio: Ratio = (lineWidth: 1/3, margin: 1/8)

    var ratio: Ratio {
        switch self {
        case .hour: return Self.hourRatio
        case .minute: return Self.minuteRatio
        }
    }

    func angle(date: Date, calendar: Calendar) -> Angle {
        switch self {
        case .hour: return .fromHour(date: date, calendar: calendar)
        case .minute: return .fromMinute(date: date, calendar: calendar)
        }
    }
}
