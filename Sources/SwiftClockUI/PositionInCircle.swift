import SwiftUI

struct PositionInCircle: ViewModifier {
    let angle: Angle
    let marginRatio: CGFloat

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content.position(.pointInCircle(
                from: self.angle,
                diameter: geometry.diameter,
                margin: geometry.diameter * self.marginRatio
                ))
        }
    }
}
