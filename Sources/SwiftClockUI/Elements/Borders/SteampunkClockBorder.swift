import SwiftUI

struct SteampunkClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/80

    @State private var windUpKeyAnimationStep = 0.0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                windUpKey(geometry: geometry)
                border(geometry: geometry)
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                    windUpKeyAnimationStep = 1
                }
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
        WindUpKey(animationStep: windUpKeyAnimationStep)
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
