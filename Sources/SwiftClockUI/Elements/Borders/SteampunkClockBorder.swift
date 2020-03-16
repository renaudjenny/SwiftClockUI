import SwiftUI

struct SteampunkClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/160


    var body: some View {
        ZStack {
            windUpKey
            border
        }.aspectRatio(contentMode: .fit)
    }

    var border: some View {
        GeometryReader { geometry in
            Circle().fill(Color.background)
            Circle().stroke(lineWidth: geometry.diameter * Self.borderWidthRatio)
        }
    }

    var windUpKey: some View {
        GeometryReader { geometry in
            WindUpKey()
                .scale(1/5)
                .stroke(lineWidth: geometry.diameter * Self.borderWidthRatio)
                .rotation(.radians(.pi * 7/4))
                .position(.pointInCircle(from: .radians(.pi * 7/4), diameter: geometry.diameter, margin: -geometry.diameter * 1/12))
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
