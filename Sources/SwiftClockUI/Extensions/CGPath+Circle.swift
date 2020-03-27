import SwiftUI

extension Path {
    mutating func addCircle(_ circle: CGRect) {
        move(to: CGPoint(x: circle.maxX, y: circle.center.y))
        addArc(center: circle.center, radius: circle.radius, startAngle: .zero, endAngle: .fullRound, clockwise: false)
    }
}
