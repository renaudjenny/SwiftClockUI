import SwiftUI

struct ClockFaceView: View {
    @Environment(\.clockFaceShown) var isShown
    @Environment(\.clockIsAnimationEnabled) var isAnimationEnabled
    @State private var circle: CGRect = .zero

    var body: some View {
        ZStack {
            leftEye
            rightEye
            mouth
        }
        .modifier(LocalFrameProvider(frame: $circle))
        .opacity(isShown ? 1 : 0)
        .animation(isAnimationEnabled ? .easeInOut : nil)
    }

    private var leftEye: some View {
        Eye(move: isShown, position: .left)
            .frame(width: circle.radius/2)
            .position(
                x: circle.radius * 2/3,
                y: circle.midY - circle.radius/3
            )
    }

    private var rightEye: some View {
        Eye(move: isShown, position: .right)
            .frame(width: circle.radius/2)
            .position(
                x: circle.radius * 4/3,
                y: circle.midY - circle.radius/3
            )
    }

    private var mouth: some View {
        Mouth(shape: self.isShown ? .smile : .neutral)
            .stroke(style: .init(lineWidth: 6.0, lineCap: .round, lineJoin: .round))
            .frame(width: circle.radius * 3/5, height: circle.radius/5)
            .position(
                x: circle.radius,
                y: circle.midY + circle.radius/2
            )
    }
}

#if DEBUG
struct ClockFaceSmiling_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    private struct Preview: View {
        @State private var isShown = true

        var body: some View {
            VStack {
                ZStack {
                    Circle().stroke()
                    ClockFaceView()
                }
                .padding()
                .environment(\.clockFaceShown, isShown)
                Button("Hide/Show", action: { self.isShown.toggle() })
            }
        }
    }
}
#endif
