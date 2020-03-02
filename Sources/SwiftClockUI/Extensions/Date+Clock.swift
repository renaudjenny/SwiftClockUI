import SwiftUI

public extension Date {
    private func positiveDegrees(angle: Angle) -> Double {
        angle.degrees > 0 ? angle.degrees : angle.degrees + 360
    }

    func hourAngle(calendar: Calendar) -> Angle {
        let minute = Double(calendar.component(.minute, from: self))
        let minuteInHour = minute > 0 ? minute/60 : 0
        let hour = Double(calendar.component(.hour, from: self)) + minuteInHour

        let relationship: Double = 360/12
        let degrees = hour * relationship
        return Angle(degrees: degrees)
    }

    func minuteAngle(calendar: Calendar) -> Angle {
        let minute = Double(calendar.component(.minute, from: self))
        let relationship: Double = 360/60
        return Angle(degrees: Double(minute) * relationship)
    }

    mutating func setHour(angle: Angle, calendar: Calendar) {
        let hour = Int((positiveDegrees(angle: angle)/Double.hourInDegree).rounded())
        let minute = calendar.component(.minute, from: self)
        self = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: self) ?? self
    }

    mutating func setMinute(angle: Angle, calendar: Calendar) {
        let minute = Int((positiveDegrees(angle: angle)/Double.minuteInDegree).rounded())
        let hour = calendar.component(.hour, from: self)
        self = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: self) ?? self
    }

    init(hour: Int, minute: Int, calendar: Calendar) {
        self.init()
        self = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: self) ?? self
    }
}
