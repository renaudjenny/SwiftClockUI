import SwiftUI

struct PositionInCircle: ViewModifier {
    let angle: Angle
    let marginRatio: CGFloat

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content.position(.pointInCircle(
                from: self.angle,
                frame: geometry.localFrame,
                margin: geometry.localDiameter * self.marginRatio
                ))
        }
    }
}
