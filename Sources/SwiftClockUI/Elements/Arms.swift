import SwiftUI
import Combine

struct Arms: View {
    var body: some View {
        ZStack {
            ArmView(type: .hour)
            ArmView(type: .minute)
        }
    }
}

#if DEBUG
struct Arms_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            Arms()
        }
        .padding()
        .modifier(PreviewEnvironmentObject())
    }
}
#endif
