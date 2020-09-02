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
        Preview().previewLayout(.sizeThatFits)
    }

    private struct Preview: View {
        var body: some View {
            GeometryReader(content: content).padding()
        }

        private func content(geometry: GeometryProxy) -> some View {
            ZStack {
                Circle().stroke().foregroundColor(Color.red.opacity(0.20))
                square(at: .degrees(0), geometry: geometry)
                square(at: .degrees(20), geometry: geometry)
                square(at: .degrees(45), geometry: geometry)
                square(at: .degrees(90), geometry: geometry)
                square(at: .degrees(540), geometry: geometry)
                square(at: .degrees(-60), geometry: geometry)
            }
        }

        func square(at angle: Angle, geometry: GeometryProxy) -> some View {
            Rectangle()
                .stroke()
                .frame(width: 10, height: 10)
                .position(
                    .inCircle(
                        geometry.frame(in: .local),
                        for: angle
                    )
            )
        }
    }
}
#endif
