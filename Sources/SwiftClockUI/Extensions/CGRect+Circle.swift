import SwiftUI

extension CGRect {
    static func circle(center: CGPoint, radius: CGFloat) -> Self {
        .init(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
    }

    var center: CGPoint { .init(x: midX, y: midY) }
    var radius: CGFloat { min(width, height)/2 }
    var circle: CGRect {
        CGRect(origin: origin, size: CGSize(width: radius * 2, height: radius * 2))
    }
}
