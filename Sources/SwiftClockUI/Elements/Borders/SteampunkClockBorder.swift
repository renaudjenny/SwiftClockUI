import SwiftUI

struct SteampunkClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/80
    @State private var circle: CGRect = .zero

    var body: some View {
        ZStack {
            windUpKey
            border
        }
        .modifier(LocalFrameProvider(frame: $circle))
    }

    var border: some View {
        ZStack {
            Circle().fill(Color.background)
            Circle().stroke(lineWidth: circle.radius * Self.borderWidthRatio)
        }
    }

    var windUpKey: some View {
        WindUpKey()
            .scale(1/8)
            .stroke(lineWidth: circle.radius * Self.borderWidthRatio)
            .rotation(.radians(.pi * 7/4))
            .position(.inCircle(circle, for: .radians(.pi * 7/4)))
            .animation(nil)
            .modifier(FlipOnAppear())
    }
}

struct SteampunkClockBorder_Previews: PreviewProvider {
    static var previews: some View {
        SteampunkClockBorder().padding()
    }
}
