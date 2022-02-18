import SwiftUI

struct SteampunkClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/80

    @State private var windUpKeyFlipAngle: Angle = .zero

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                windUpKey(geometry: geometry)
                border(geometry: geometry)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                windUpKeyFlipAngle += .fullRound
            }
        }
    }

    private func border(geometry: GeometryProxy) -> some View {
        ZStack {
            Circle().fill(Color.background)
            Circle().strokeBorder(lineWidth: geometry.radius * Self.borderWidthRatio)
        }
    }

    private func windUpKey(geometry: GeometryProxy) -> some View {
        WindUpKey()
            .stroke(lineWidth: geometry.radius * Self.borderWidthRatio)
            .rotation(.degrees(-45))
            .frame(width: geometry.radius * 1/4, height: geometry.radius * 1/4)
            .position(
                .inCircle(
                    geometry.circle,
                    for: .degrees(-45),
                    margin: -geometry.radius * 1/10
                )
            )
            .rotation3DEffect(windUpKeyFlipAngle, axis: (x: 1, y: 1, z: 0))
    }
}

#if DEBUG
struct SteampunkClockBorder_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SteampunkClockBorder()
            SteampunkClockBorder()
                .previewLayout(.fixed(width: 400, height: 200))
        }
    }
}
#endif
