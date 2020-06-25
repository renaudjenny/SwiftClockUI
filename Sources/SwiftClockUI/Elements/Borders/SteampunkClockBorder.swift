import SwiftUI

struct SteampunkClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/80

    var body: some View {
        ZStack {
            windUpKey
            border
        }
    }

    var border: some View {
        GeometryReader { geometry in
            Circle().fill(Color.background)
            Circle().stroke(lineWidth: geometry.radius * Self.borderWidthRatio)
        }
    }

    var windUpKey: some View {
        GeometryReader { geometry in
            WindUpKey()
                .scale(1/8)
                .stroke(lineWidth: geometry.radius * Self.borderWidthRatio)
                .rotation(.radians(.pi * 7/4))
                .position(.inCircle(geometry.circle, for: .radians(.pi * 7/4), margin: -geometry.radius * 1/10))
                .animation(nil)
                .modifier(FlipOnAppear())
        }
    }
}

struct SteampunkClockBorder_Previews: PreviewProvider {
    static var previews: some View {
        SteampunkClockBorder().padding()
    }
}
