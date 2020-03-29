import SwiftUI

extension Angle {
    static let fullRound: Self = .radians(2 * .pi)

    static func inCircle(for point: CGPoint, circleCenter: CGPoint) -> Self {
        .radians(Double(atan2(
            point.y - circleCenter.y,
            point.x - circleCenter.x
        )))
    }
}
