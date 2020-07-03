import SwiftUI

extension ClockFaceView {
    struct Eye: View {
        let move: Bool
        let position: Position

        var body: some View {
            ZStack {
                // TODO: Iris should be proportional of the size instead of hardcoded value
                Circle().stroke(lineWidth: 4)
                ClockFaceView.Iris(move: move, position: position).fill()
            }
        }
    }

    private struct Iris: Shape {
        let position: Position
        private var animationStep: Double
        static let width: CGFloat = 15

        var animatableData: Double {
            get { self.animationStep }
            set { self.animationStep = newValue }
        }

        init(move: Bool, position: Position) {
            self.animationStep = move ? 1 : 0
            self.position = position
        }

        func path(in rect: CGRect) -> Path {
            let animationStep = CGFloat(self.animationStep)

            let directionCenter = CGPoint.inCircle(rect, for: position.angle, margin: Self.width)

            let center = rect.center
            let eyeCenter = CGPoint(
                x: (1 - animationStep) * center.x + directionCenter.x * animationStep,
                y: (1 - animationStep) * center.y + directionCenter.y * animationStep
            )

            let iris = CGRect.circle(
                center: eyeCenter,
                radius: Self.width
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
        @State private var move = true

        var body: some View {
            VStack {
                ClockFaceView.Eye(move: false, position: .left)
                ClockFaceView.Eye(move: move, position: .left)
                ClockFaceView.Eye(move: move, position: .right)
                Button(action: { self.move.toggle() }) {
                    Text("Move eyes")
                }
            }
            .animation(.default)
            .padding()
        }
    }
}
#endif
