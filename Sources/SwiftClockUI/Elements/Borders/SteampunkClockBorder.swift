import SwiftUI

struct SteampunkClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/80

    var body: some View {
        GeometryReader { geometry in
            Circle().stroke(lineWidth: geometry.diameter * Self.borderWidthRatio)
            WindUpKey()
                .scale(1/5)
                .stroke(lineWidth: geometry.diameter * Self.borderWidthRatio)
                .rotation(.radians(.pi * 7/4))
                .position(.pointInCircle(from: .radians(.pi * 7/4), diameter: geometry.diameter, margin: -geometry.diameter * 1/10))
                .animation(nil)
                .rotation3DEffect(.radians(2 * .pi), axis: (x: 1, y: 1, z: 0))
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
        }
        .aspectRatio(contentMode: .fit)
    }
}

struct SteampunkClockBorder_Previews: PreviewProvider {
    static var previews: some View {
        SteampunkClockBorder().padding()
    }
}
