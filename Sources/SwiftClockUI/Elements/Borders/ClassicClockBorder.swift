import SwiftUI

struct ClassicClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/35

    var body: some View {
        GeometryReader {
            Circle()
                .stroke(lineWidth: $0.radius * Self.borderWidthRatio)
                .modifier(ScaleUpOnAppear())
        }
    }
}

#if DEBUG
struct ClassicClockBorder_Previews: PreviewProvider {
    static var previews: some View {
        ClassicClockBorder().padding()
    }
}
#endif
