import SwiftUI

struct FontProportional: ViewModifier {
    let ratio: CGFloat

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content.font(.system(size: self.ratio * geometry.localDiameter))
        }
    }
}
