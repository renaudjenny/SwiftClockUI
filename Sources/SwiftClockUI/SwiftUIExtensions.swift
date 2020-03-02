import SwiftUI

// TODO: clean-up. All Extensions shouldn't be in the same file
extension Double {
    static let hourInDegree: Double = 360/12
    static let minuteInDegree: Double = 360/60
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
    var diameter: CGFloat { return min(self.size.width, self.size.height) }
}

extension CGPoint {
    static func pointInCircle(from angle: Angle, diameter: CGFloat, margin: CGFloat = 0.0) -> Self {
        let radius = diameter/2 - margin

        let radians = CGFloat(angle.radians) - CGFloat.pi/2
        let x = radius * cos(radians)
        let y = radius * sin(radians)

        return CGPoint(x: x + diameter/2, y: y + diameter/2)
    }
}
