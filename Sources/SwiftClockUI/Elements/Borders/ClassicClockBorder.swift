import SwiftUI

struct ClassicClockBorder: View {
    var body: some View {
        Circle().stroke(lineWidth: 2)
    }
}

#if DEBUG
struct ClassicClockBorder_Previews: PreviewProvider {
    static var previews: some View {
        ClassicClockBorder().padding()
    }
}
#endif
