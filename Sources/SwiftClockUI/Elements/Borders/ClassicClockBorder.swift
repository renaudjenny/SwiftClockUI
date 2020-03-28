import SwiftUI

struct ClassicClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/35
    
    var body: some View {
        GeometryReader { geometry in
            Circle()
                .stroke(lineWidth: geometry.radius * Self.borderWidthRatio)
                .aspectRatio(contentMode: .fit)
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
