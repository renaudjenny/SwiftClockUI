import SwiftUI

struct ClockFaceView: View {
    @Environment(\.clockFaceShown) var isShown
    @Environment(\.clockIsAnimationEnabled) var isAnimationEnabled

    var body: some View {
        GeometryReader(content: content)
    }

    private func content(geometry: GeometryProxy) -> some View {
        ZStack {
            leftEye(geometry: geometry)
            rightEye(geometry: geometry)
            mouth(geometry: geometry)
        }
        .opacity(isShown ? 1 : 0)
        .animation(isAnimationEnabled ? .easeInOut : nil, value: isShown)
    }

    private func leftEye(geometry: GeometryProxy) -> some View {
        Eye(move: isShown, position: .left)
            .scaleEffect(1/4)
            .position(
                x: geometry.frame(in: .local).midX - geometry.radius * 2/5,
                y: geometry.frame(in: .local).midY - geometry.radius/3
            )
    }

    private func rightEye(geometry: GeometryProxy) -> some View {
        Eye(move: isShown, position: .right)
            .scaleEffect(1/4)
            .position(
                x: geometry.frame(in: .local).midX + geometry.radius * 2/5,
                y: geometry.frame(in: .local).midY - geometry.radius/3
            )
    }

    private func mouth(geometry: GeometryProxy) -> some View {
        Mouth(shape: isShown ? .smile : .neutral)
            .stroke(style: .init(
                lineWidth: geometry.radius * 1/20,
                lineCap: .round,
                lineJoin: .round
            ))
            .frame(width: geometry.radius * 3/5, height: geometry.radius/5)
            .position(
                x: geometry.frame(in: .local).midX,
                y: geometry.frame(in: .local).midY + geometry.radius/2
            )
    }
}

#if DEBUG
struct ClockFaceSmiling_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Preview()
            Preview().previewLayout(.fixed(width: 800, height: 400))
        }
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
