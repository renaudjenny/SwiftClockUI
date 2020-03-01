import SwiftUI

struct ScaleProportional: ViewModifier {
    let ratio: CGFloat

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content.scaleEffect(geometry.diameter * self.ratio)
        }
    }
}
