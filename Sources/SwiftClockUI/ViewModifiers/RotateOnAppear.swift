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
                withSlightyDelayedAnimation(animation) {
                    rotationAngle = clockwise ? .fullRound : -.fullRound
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
        Group {
            Rectangles()
            Navigation()
        }
    }

    private struct Rectangles: View {
        var body: some View {
            VStack(spacing: 50) {
                Rectangle()
                    .frame(width: 100, height: 100)
                    .modifier(RotateOnAppear())
                Rectangle()
                    .frame(width: 100, height: 100)
                    .modifier(RotateOnAppear(clockwise: false))
            }
            .frame(width: 200, height: 300)
        }
    }

    private struct Navigation: View {
        @State var isShown = false

        var body: some View {
            NavigationView {
                VStack {
                    NavigationLink("Preview 3") {
                        VStack {
                            Button("Show!") { self.isShown = !self.isShown }
                            Text(isShown ? "It's shown" : "It's hidden")
                        }
                    }
                    if isShown { Rectangles() }
                }
            }
        }
    }
}
