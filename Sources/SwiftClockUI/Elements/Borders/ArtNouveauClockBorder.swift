import SwiftUI

struct ArtNouveauClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/100
    static let innerCircleScale: CGFloat = 9/10
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(lineWidth: geometry.diameter * Self.borderWidthRatio)
                Circle()
                    .scale(Self.innerCircleScale)
                    .transform(.init(
                        translationX: 0,
                        y: geometry.diameter/2 * (1 - Self.innerCircleScale)))
                    .stroke(lineWidth: geometry.diameter * Self.borderWidthRatio/4)
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
