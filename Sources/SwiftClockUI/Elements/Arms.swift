import SwiftUI
import Combine

struct Arms: View {
    var body: some View {
        ZStack {
            ArmView(type: .hour)
            ArmView(type: .minute)
        }
        .modifier(OnHover())
        .animation(.easeInOut)
    }
}

struct OnHover: ViewModifier {
    @State var isHover: Bool = false

    func body(content: Content) -> some View {
        #if os(macOS)
        return content
            .onHover { self.isHover = $0 }
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.44), radius: isDragShadowShown ? 6 : 0)
            .scaleEffect(isDragShadowShown ? 1.1 : 1)
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
