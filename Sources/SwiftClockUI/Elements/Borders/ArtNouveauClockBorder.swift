import SwiftUI

struct ArtNouveauClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/50
    static let innerCircleScale: CGFloat = 9/10
    @State private var circle: CGRect = .zero

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: circle.radius * Self.borderWidthRatio)
            Circle()
                .scale(Self.innerCircleScale)
                .transform(.init(
                    translationX: 0,
                    y: circle.radius * (1 - Self.innerCircleScale)
                ))
                .stroke(lineWidth: circle.radius * Self.borderWidthRatio/2)
        }
        .modifier(LocalFrameProvider(frame: $circle))
    }
}

#if DEBUG
struct ArtNouveauClockBorderClockBorder_Previews: PreviewProvider {
    static var previews: some View {
        ArtNouveauClockBorder().padding()
    }
}
#endif
