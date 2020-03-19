import SwiftUI

extension CGPoint {
    // TODO: change diameter by radius (it makes more sense)
    // TODO: change the name by inCircle (it makes more sense)
    static func pointInCircle(from angle: Angle, diameter: CGFloat, margin: CGFloat = 0.0) -> Self {
        let radius = diameter/2 - margin

        let radians = CGFloat(angle.radians) - CGFloat.pi/2
        let x = radius * cos(radians)
        let y = radius * sin(radians)

        return CGPoint(x: x + diameter/2, y: y + diameter/2)
    }

    // TODO: merge this method (set it to private) with the other one
    // TODO: add unit test
    func recenteredCircle(center: CGPoint, diameter: CGFloat) -> Self {
        let transform = CGAffineTransform(translationX: center.x - diameter/2, y: center.y - diameter/2)
        return self.applying(transform)
    }
}

extension Angle {
    // TODO: add unit tests
    static func inCircle(for point: CGPoint, circleCenter: CGPoint) -> Self {
        Angle(radians: Double(atan2(
            point.y - circleCenter.y,
            point.x - circleCenter.x
        )))
    }
}
