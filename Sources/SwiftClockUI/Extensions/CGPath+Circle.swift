import SwiftUI

extension Path {
    mutating func addCircle(_ circle: CGRect) {
        move(to: CGPoint(x: circle.maxX, y: circle.center.y))
        addArc(center: circle.center, radius: circle.radius, startAngle: .zero, endAngle: .fullRound, clockwise: false)
    }

    mutating func addTest(to center: CGPoint) {
        let previous = currentPoint ?? .zero
        addCircle(CGRect.circle(center: center, radius: 2))
        move(to: previous)
    }
}
