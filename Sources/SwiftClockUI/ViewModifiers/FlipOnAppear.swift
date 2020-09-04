import SwiftUI

struct FlipOnAppear: ViewModifier {
    @Environment(\.clockIsAnimationEnabled) var isAnimationEnabled
    @State var rotationAngle: Angle = .zero

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(rotationAngle, axis: (x: 1, y: 1, z: 0))
            .onAppear {
                guard self.isAnimationEnabled else { return }

                self.rotationAngle = .zero
                let animation = Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)
                withAnimation(animation) {
                    self.rotationAngle = .fullRound
                }
        }
    }
}

struct FlipOnAppear_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
            .rotationEffect(.degrees(-45))
            .modifier(FlipOnAppear())
    }
}
