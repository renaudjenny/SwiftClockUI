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
            .stroke(lineWidth: circle.radius * Self.borderWidthRatio)
            .rotation(.degrees(-45))
            .frame(width: circle.radius * 1/4, height: circle.radius * 1/4)
            .position(
                .inCircle(
                    circle,
                    for: .degrees(-45),
                    margin: -circle.radius * 1/10
                ))
            .animation(nil)
            .modifier(FlipOnAppear())
    }
}

struct SteampunkClockBorder_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SteampunkClockBorder().padding()
            SteampunkClockBorder().previewLayout(.fixed(width: 400, height: 200)).padding()
        }
    }
}
