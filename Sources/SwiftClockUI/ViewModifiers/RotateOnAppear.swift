import SwiftUI

struct RotateOnAppear: ViewModifier {
    @Environment(\.clockIsAnimationEnabled) var isAnimationEnabled
    @State var animate = false
    var clockwise = true

    func body(content: Content) -> some View {
        content
            .rotationEffect(rotationAngle)
            .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true))
            .onAppear { self.animate = true }
    }

    var rotationAngle: Angle {
        guard isAnimationEnabled else { return .zero }
        if clockwise {
            return animate ? .fullRound : .zero
        } else {
            return animate ? -.fullRound : .zero
        }
    }
}
