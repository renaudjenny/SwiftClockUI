import SwiftUI

struct FlipOnAppear: ViewModifier {
    @Environment(\.clockIsAnimationEnabled) var isAnimationEnabled
    @State var rotationAngle: Angle = .zero

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(rotationAngle, axis: (x: 1, y: 1, z: 0))
            .onAppear {
                guard self.isAnimationEnabled else { return }
                let animation = Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)
                withAnimation(animation) {
                    self.rotationAngle = .fullRound
                }
            }
            .onDisappear {
                self.rotationAngle = .zero
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
