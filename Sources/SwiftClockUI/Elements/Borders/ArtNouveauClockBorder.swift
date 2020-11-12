import SwiftUI

struct ArtNouveauClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/50
    static let innerCircleScale: CGFloat = 9/10

    var body: some View {
        GeometryReader(content: content)
    }

    private func content(geometry: GeometryProxy) -> some View {
        ZStack {
            Circle()
                .strokeBorder(lineWidth: geometry.radius * Self.borderWidthRatio)
            Circle()
                .strokeBorder(lineWidth: geometry.radius * Self.borderWidthRatio/2)
                .scaleEffect(Self.innerCircleScale)
                .transformEffect(.init(
                    translationX: 0,
                    y: geometry.radius * (1 - Self.innerCircleScale)
                ))
        }
    }
}

#if DEBUG
struct ArtNouveauClockBorderClockBorder_Previews: PreviewProvider {
    static var previews: some View {
        ArtNouveauClockBorder().padding()
    }
}
#endif
