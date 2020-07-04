import SwiftUI

extension ClockFaceView {
    struct Eye: View {
        let move: Bool
        let position: Position
        @State private var circle: CGRect = .zero

        var body: some View {
            ZStack {
                Circle().stroke(lineWidth: circle.radius * 1/6)
                ClockFaceView.Iris(move: move, position: position).fill()
            }.modifier(LocalFrameProvider(frame: $circle))
        }
    }

    private struct Iris: Shape {
        let position: Position
        private var animationStep: Double

        var animatableData: Double {
            get { self.animationStep }
            set { self.animationStep = newValue }
        }

        init(move: Bool, position: Position) {
            self.animationStep = move ? 1 : 0
            self.position = position
        }

        func path(in rect: CGRect) -> Path {
            let width = rect.radius/4
            let animationStep = CGFloat(self.animationStep)

            let directionCenter = CGPoint.inCircle(rect, for: position.angle, margin: width)

            let center = rect.center
            let eyeCenter = CGPoint(
                x: (1 - animationStep) * center.x + directionCenter.x * animationStep,
                y: (1 - animationStep) * center.y + directionCenter.y * animationStep
            )

            let iris = CGRect.circle(
                center: eyeCenter,
                radius: width
            )

            var path = Path()
            path.addEllipse(in: iris)
            return path
        }
    }

    enum Position {
        case left
        case right

        var angle: Angle {
            switch self {
            case .left: return .radians(.pi * 3/4)
            case .right: return .radians(-.pi * 3/4)
            }
        }
    }
}

#if DEBUG
struct Eye_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    struct Preview: View {
        @Environment(\.clockIsAnimationEnabled) private var isAnimationEnabled
        @State private var move = true

        var body: some View {
            VStack {
                ClockFaceView.Eye(move: false, position: .left).padding()
                ClockFaceView.Eye(move: move, position: .left).padding()
                ClockFaceView.Eye(move: move, position: .right).padding()
                Button(action: { self.move.toggle() }) {
                    Text("Move eyes")
                }
            }
            .animation(isAnimationEnabled ? .default : nil)
            .padding()
        }
    }
}
#endif
