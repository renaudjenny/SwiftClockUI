import SwiftUI

struct ClassicClockBorder: View {
    static let borderWidthRatio: CGFloat = 1/70
    
    var body: some View {
        GeometryReader { geometry in
            Circle()
                .stroke(lineWidth: geometry.diameter * Self.borderWidthRatio)
                .aspectRatio(1/1, contentMode: .fit)
        }
    }
}

#if DEBUG
struct ClassicClockBorder_Previews: PreviewProvider {
    // TODO: get something nice and relevant here and add a snapshot test!
    static var previews: some View {
        ClassicClockBorder().padding()
    }
}
#endif
