import SwiftUI

extension CGPoint {
    static func inCircle(_ circle: CGRect, for angle: Angle, margin: CGFloat = 0.0) -> Self {
        let radians = CGFloat(angle.radians) - .pi/2
        return CGPoint(
            x: circle.midX + (circle.radius - margin) * cos(radians),
            y: circle.midY + (circle.radius - margin) * sin(radians)
        )
    }
}
