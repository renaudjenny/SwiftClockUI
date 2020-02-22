import SwiftUI

// TODO: clean-up. All Extensions shouldn't be in the same file
extension Double {
    static let hourInDegree: Double = 30
    static let minuteInDegree = 6.0
}

public extension Date {
    init(hour: Int, minute: Int, calendar: Calendar) {
        self.init()
        self = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: self) ?? self
    }
}

extension Color {
    static var background: Self {
        #if os(iOS)
        return Self(UIColor.systemBackground)
        #else
        return Self(NSColor.windowBackgroundColor)
        #endif
    }
}

extension GeometryProxy {
    var localFrame: CGRect { self.frame(in: .local) }
    var localWidth: CGFloat { self.localFrame.width }
    var localHeight: CGFloat { self.localFrame.height }
    var localDiameter: CGFloat { return min(self.localWidth, self.localHeight) }
}

extension Angle {
    static func fromHour(date: Date, calendar: Calendar) -> Angle {
        let minute = Double(calendar.component(.minute, from: date))
        let minuteInHour = minute > 0 ? minute/60 : 0
        let hour = Double(calendar.component(.hour, from: date)) + minuteInHour

        let relationship: Double = 360/12
        let degrees = hour * relationship
        return Angle(degrees: degrees)
    }

    static func fromMinute(date: Date, calendar: Calendar) -> Angle {
        let minute = Double(calendar.component(.minute, from: date))
        let relationship: Double = 360/60
        return Angle(degrees: Double(minute) * relationship)
    }
}

extension CGPoint {
    static func pointInCircle(from angle: Angle, frame: CGRect, margin: CGFloat = 0.0) -> Self {
        let radius = (min(frame.width, frame.height) / 2) - margin

        let radians = CGFloat(angle.radians) - CGFloat.pi/2
        let x = radius * cos(radians)
        let y = radius * sin(radians)

        return CGPoint(x: x, y: y).applying(.init(
            translationX: frame.width/2, y: frame.height/2
        ))
    }
}
