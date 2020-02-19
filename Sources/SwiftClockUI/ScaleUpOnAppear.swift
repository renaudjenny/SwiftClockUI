import SwiftUI

struct ScaleUpOnAppear: ViewModifier {
  @State private var isShown = false

  func body(content: Content) -> some View {
    content
      .scaleEffect(self.isShown || Current.isAnimationDisabled ? 1 : 0.1)
      .animation(.spring())
      .onAppear(perform: { self.isShown = true })
  }
}
