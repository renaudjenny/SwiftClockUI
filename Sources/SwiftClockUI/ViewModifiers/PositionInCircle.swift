import SwiftUI

struct PositionInCircle: ViewModifier {
    let angle: Angle
    let marginRatio: CGFloat

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content.position(.inCircle(
                geometry.circle,
                for: self.angle,
                margin: geometry.radius * self.marginRatio
            ))
        }
    }
}
