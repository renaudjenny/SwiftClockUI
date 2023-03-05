import SwiftUI

extension ClockFaceView {
    struct Eye: View {
        let move: Bool
        let position: Position

        var body: some View {
            GeometryReader(content: content)
        }

        private func content(geometry: GeometryProxy) -> some View {
            ZStack {
                Circle().stroke(lineWidth: geometry.radius * 1/6)
                ClockFaceView.Iris(move: move, position: position).fill()
            }
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
        VStack {
            ClockFaceView.Eye(move: false, position: .left).padding(2)
            HStack {
                ClockFaceView.Eye(move: true, position: .left).padding(2)
                ClockFaceView.Eye(move: true, position: .right).padding(2)
            }
        }
        .padding(4)
    }
}

struct EyeWithMove_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    struct Preview: View {
        @State private var move = true

        var body: some View {
            VStack {
                ClockFaceView.Eye(move: false, position: .left).padding()
                ClockFaceView.Eye(move: move, position: .left).padding()
                ClockFaceView.Eye(move: move, position: .right).padding()
                Button(
                    action: { withAnimation { self.move.toggle() } },
                    label: {
                        Text("Move eyes")
                    }
                )
            }
            .padding()
        }
    }
}
#endif
