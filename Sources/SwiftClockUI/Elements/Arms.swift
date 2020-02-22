import SwiftUI
import Combine

struct Arms: View {
    @State var isDragShadowShown = false

    var body: some View {
        ZStack {
            ArmView(type: .hour)
            ArmView(type: .minute)
        }
        .modifier(OnHover(isHover: $isDragShadowShown))
        .scaleEffect(isDragShadowShown ? 1.1 : 1)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.44), radius: isDragShadowShown ? 6 : 0)
        .animation(.easeInOut)
    }
}

struct OnHover: ViewModifier {
    @Binding var isHover: Bool

    func body(content: Content) -> some View {
        #if os(macOS)
        return content.onHover { self.isHover = $0 }
        #else
        return content
        #endif
    }
}

#if DEBUG
struct Arms_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            Arms()
        }.padding()
    }
}
#endif
