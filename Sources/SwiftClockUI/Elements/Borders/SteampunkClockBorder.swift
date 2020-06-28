import SwiftUI

struct SteampunkClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/80
    @State private var radius: CGFloat = .zero

    var body: some View {
        ZStack {
            windUpKey
            border
        }.modifier(RadiusProvider(radius: $radius))
    }

    var border: some View {
        // FIXME: fix that!
//            Circle().fill(Color.background)
        Circle().stroke(lineWidth: radius * Self.borderWidthRatio)
    }

    var windUpKey: some View {
        WindUpKey()
            .scale(1/8)
            .stroke(lineWidth: radius * Self.borderWidthRatio)
            .rotation(.radians(.pi * 7/4))
            .position(.inCircle(circle, for: .radians(.pi * 7/4), margin: -circle.radius * 0))
            .animation(nil)
            .modifier(FlipOnAppear())
    }

    private var circle: CGRect {
        CGRect(x: 0, y: 0, width: radius, height: radius)
    }
}

struct SteampunkClockBorder_Previews: PreviewProvider {
    static var previews: some View {
        SteampunkClockBorder().padding()
    }
}
