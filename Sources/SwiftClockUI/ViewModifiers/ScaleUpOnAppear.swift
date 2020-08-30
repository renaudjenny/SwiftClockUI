import SwiftUI

struct ScaleUpOnAppear: ViewModifier {
    @Environment(\.clockIsAnimationEnabled) var isAnimationEnabled
    @State private var scale: CGFloat = 1

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .onAppear(perform: {
                guard self.isAnimationEnabled else { return }
                withAnimation(.spring()) {
                    self.scale = 0.1
                }
                withAnimation(.spring()) {
                    self.scale = 1
                }
            })
    }
}

struct ScaleUpOnAppear_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello, World!").modifier(ScaleUpOnAppear())
            Text("Animation deactivated")
                .modifier(ScaleUpOnAppear())
                .environment(\.clockIsAnimationEnabled, false)
        }
    }
}
