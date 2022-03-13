import SwiftUI

struct ClassicClockBorder: View {
    var body: some View {
        Circle().strokeBorder(lineWidth: 2)
    }
}

#if DEBUG
struct ClassicClockBorder_Previews: PreviewProvider {
    static var previews: some View {
        ClassicClockBorder().padding()
    }
}
#endif
