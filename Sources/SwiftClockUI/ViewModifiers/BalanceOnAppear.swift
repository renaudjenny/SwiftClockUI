import SwiftUI

struct BalanceOnAppear: ViewModifier {
    @Environment(\.clockIsAnimationEnabled) var isAnimationEnabled
    @State var animate = false
    var clockwise = true

    func body(content: Content) -> some View {
        content
            .rotationEffect(rotationAngle)
            .animation(Animation.linear(duration: 4).repeatForever(autoreverses: true), value: animate)
            .onAppear { self.animate = true }
    }

    var rotationAngle: Angle {
        guard isAnimationEnabled else { return .zero }
        return animate ? .degrees(20) : -.degrees(20)
    }
}
