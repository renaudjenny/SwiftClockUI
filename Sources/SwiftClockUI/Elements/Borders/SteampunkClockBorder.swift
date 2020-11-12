import SwiftUI

struct SteampunkClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/80

    var body: some View {
        GeometryReader(content: content)
    }

    private func content(geometry: GeometryProxy) -> some View {
        ZStack {
            windUpKey(geometry: geometry)
            border(geometry: geometry)
        }
    }

    private func border(geometry: GeometryProxy) -> some View {
        ZStack {
            Circle().fill(Color.background)
            Circle().strokeBorder(lineWidth: geometry.radius * Self.borderWidthRatio)
        }
    }

    private func windUpKey(geometry: GeometryProxy) -> some View {
        WindUpKey()
            .stroke(lineWidth: geometry.radius * Self.borderWidthRatio)
            .rotation(.degrees(-45))
            .frame(width: geometry.radius * 1/4, height: geometry.radius * 1/4)
            .position(
                .inCircle(
                    geometry.circle,
                    for: .degrees(-45),
                    margin: -geometry.radius * 1/10
                )
            )
            .modifier(FlipOnAppear())
    }
}

#if DEBUG
struct SteampunkClockBorder_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SteampunkClockBorder()
            SteampunkClockBorder()
                .previewLayout(.fixed(width: 400, height: 200))
        }
    }
}
#endif
