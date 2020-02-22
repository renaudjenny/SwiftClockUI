import SwiftUI

struct ClassicClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/70
    
    var body: some View {
        GeometryReader { geometry in
            Circle()
                .stroke(lineWidth: geometry.diameter * Self.borderWidthRatio)
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
