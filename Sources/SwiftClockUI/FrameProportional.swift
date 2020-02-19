import SwiftUI

struct FrameProportional: ViewModifier {
    let widthRatio: CGFloat
    let heightRatio: CGFloat

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content.frame(
                width: geometry.localWidth * self.widthRatio,
                height: geometry.localHeight * self.heightRatio
            )
        }
    }
}
