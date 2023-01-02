import SwiftUI

struct SteampunkClockBorder: View {
    @State private var windUpKeyAnimationStep = 0.0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                windUpKey(geometry: geometry)
                border()
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

    private func border() -> some View {
        ZStack {
            Circle().fill(Color.background)
            Circle().strokeBorder(lineWidth: 2)
        }
    }

    private func windUpKey(geometry: GeometryProxy) -> some View {
        WindUpKey(animationStep: windUpKeyAnimationStep)
            .stroke(lineWidth: 2)
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
        SteampunkClockBorder()
    }
}
#endif
