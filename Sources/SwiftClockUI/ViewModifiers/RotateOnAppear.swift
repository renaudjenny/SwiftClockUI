import SwiftUI

struct RotateOnAppear: ViewModifier {
    @Environment(\.clockIsAnimationEnabled) var isAnimationEnabled
    @State private var rotationAngle: Angle = .zero
    var clockwise = true

    func body(content: Content) -> some View {
        content
            .rotationEffect(rotationAngle)
            .onAppear {
                guard self.isAnimationEnabled else { return }

                self.rotationAngle = .zero
                withAnimation(self.animation.delay(0.1)) {
                    self.rotationAngle = self.clockwise ? .fullRound : -.fullRound
                }
            }
    }

    private var animation: Animation {
        Animation
            .linear(duration: 4)
            .repeatForever(autoreverses: false)
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
