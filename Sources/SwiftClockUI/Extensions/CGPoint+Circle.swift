import SwiftUI

extension CGPoint {
    static func inCircle(_ circle: CGRect, for angle: Angle, margin: CGFloat = 0.0) -> Self {
        let radians = CGFloat(angle.radians) - .pi/2
        return CGPoint(
            x: circle.midX + (circle.radius - margin) * cos(radians),
            y: circle.midY + (circle.radius - margin) * sin(radians)
        )
    }
}

#if DEBUG
struct CGPointCircle_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    private struct Preview: View {
        @State private var frame: CGRect = .zero

        var body: some View {
            ZStack {
                Circle().stroke().foregroundColor(Color.red.opacity(0.20))
                square(at: .degrees(20))
                square(at: .degrees(45))
                square(at: .degrees(90))
                square(at: .degrees(540))
                square(at: .degrees(-60))
            }
            .modifier(LocalFrameProvider(frame: $frame))
            .previewLayout(.sizeThatFits)
            .padding()
        }

        func square(at angle: Angle) -> some View {
            Rectangle()
                .stroke()
                .frame(width: 10, height: 10)
                .position(
                    .inCircle(frame, for: angle)
                )
        }
    }
}
#endif
