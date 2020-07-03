import SwiftUI

struct ScaleUpOnAppear: ViewModifier {
    @Environment(\.clockIsAnimationEnabled) var isAnimationEnabled
    @State private var isShown = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(scaleValue)
            .onAppear(perform: {
                withAnimation(.spring()) {
                    self.isShown = true
                }
            })
    }

    var scaleValue: CGFloat {
        if isAnimationEnabled {
            return self.isShown ? 1 : 0.1
        } else {
            return 1
        }
    }
}
