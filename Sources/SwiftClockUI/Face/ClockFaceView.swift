import SwiftUI

struct ClockFaceView: View {
    @Environment(\.clockFaceShown) var isShown

    var body: some View {
        GeometryReader { geometry in
            leftEye(geometry: geometry)
            rightEye(geometry: geometry)
            mouth(geometry: geometry)
        }
        .opacity(isShown ? 1 : 0)
        .animation(.easeInOut)
    }

    func leftEye(geometry: GeometryProxy) -> some View {
        Eye(move: isShown, position: .left)
            .frame(width: geometry.radius/2)
            .position(
                x: geometry.radius * 2/3,
                y: geometry.circle.midY - geometry.radius/3
            )
    }

    func rightEye(geometry: GeometryProxy) -> some View {
        Eye(move: isShown, position: .right)
            .frame(width: geometry.radius/2)
            .position(
                x: geometry.radius * 4/3,
                y: geometry.circle.midY - geometry.radius/3
            )
    }

    func mouth(geometry: GeometryProxy) -> some View {
        Mouth(shape: self.isShown ? .smile : .neutral)
            .stroke(style: .init(lineWidth: 6.0, lineCap: .round, lineJoin: .round))
            .frame(width: geometry.radius * 3/5, height: geometry.radius/5)
            .position(
                x: geometry.radius,
                y: geometry.circle.midY + geometry.radius/2
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
                .animation(
                    Animation
                        .default
                        .speed(1/4)
                        .repeatForever(autoreverses: true)
                )
                .environment(\.clockFaceShown, isShown)
                Button("Hide/Show", action: { self.isShown.toggle() })
            }
        }
    }
}
#endif
