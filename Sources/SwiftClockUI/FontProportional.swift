import SwiftUI

struct FontProportional: ViewModifier {
    let ratio: CGFloat

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content.font(.system(size: (geometry.diameter * self.ratio).rounded()))
        }
    }
}
