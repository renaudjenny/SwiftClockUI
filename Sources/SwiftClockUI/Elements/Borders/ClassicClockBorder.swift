import SwiftUI

struct ClassicClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/35
    @State private var circle: CGRect = .zero

    var body: some View {
        Circle()
            .stroke(lineWidth: circle.radius * Self.borderWidthRatio)
            .modifier(ScaleUpOnAppear())
            .modifier(LocalFrameProvider(frame: $circle))
    }
}

#if DEBUG
struct ClassicClockBorder_Previews: PreviewProvider {
    static var previews: some View {
        ClassicClockBorder().padding()
    }
}
#endif
