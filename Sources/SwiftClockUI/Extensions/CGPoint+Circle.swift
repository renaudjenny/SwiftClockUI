import SwiftUI

extension CGPoint {
    static func pointInCircle(from angle: Angle, diameter: CGFloat, margin: CGFloat = 0.0) -> Self {
        let radius = diameter/2 - margin

        let radians = CGFloat(angle.radians) - CGFloat.pi/2
        let x = radius * cos(radians)
        let y = radius * sin(radians)

        return CGPoint(x: x + diameter/2, y: y + diameter/2)
    }

    func recenteredCircle(center: CGPoint, diameter: CGFloat) -> Self {
        let transform = CGAffineTransform(translationX: center.x - diameter/2, y: center.y - diameter/2)
        return self.applying(transform)
    }
}
