import SwiftUI

struct FlipOnAppear: ViewModifier {
    @Environment(\.clockIsAnimationEnabled) var isAnimationEnabled
    @State var animate = false

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(animate && isAnimationEnabled ? .fullRound : .zero, axis: (x: 1, y: 1, z: 0))
            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
            .onAppear { self.animate = true }
    }
}
