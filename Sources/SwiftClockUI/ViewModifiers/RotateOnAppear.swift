import SwiftUI

struct RotateOnAppear: ViewModifier {
    @Environment(\.clockIsAnimationEnabled) var isAnimationEnabled
    @State private var animate = false
    var clockwise = true

    func body(content: Content) -> some View {
        content
            .rotationEffect(rotationAngle)
            .animation(animation)
            .onAppear {
                self.animate = true
            }
    }

    private var animation: Animation {
        Animation
            .linear(duration: 4)
            .repeatForever(autoreverses: false)
    }

    private var rotationAngle: Angle {
        guard isAnimationEnabled else { return .zero }
        if clockwise {
            return animate ? .fullRound : .zero
        } else {
            return animate ? -.fullRound : .zero
        }
    }
}

struct RotateOnAppear_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 50) {
            Rectangle()
                .frame(width: 100, height: 100)
                .modifier(RotateOnAppear())
            Rectangle()
                .frame(width: 100, height: 100)
                .modifier(RotateOnAppear(clockwise: false))
        }
    }
}
