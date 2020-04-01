import SwiftUI

struct ArtNouveauClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/50
    static let innerCircleScale: CGFloat = 9/10

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(lineWidth: geometry.radius * Self.borderWidthRatio)
                Circle()
                    .scale(Self.innerCircleScale)
                    .transform(.init(
                        translationX: 0,
                        y: geometry.radius * (1 - Self.innerCircleScale)))
                    .stroke(lineWidth: geometry.radius * Self.borderWidthRatio/2)
            }.aspectRatio(1/1, contentMode: .fit)
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
