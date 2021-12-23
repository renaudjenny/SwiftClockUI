import SwiftUI
import Combine

struct Arms: View {
    var body: some View {
        ZStack {
            ArmView(type: .hour)
            ArmView(type: .minute)
        }
        .modifier(OnHover())
    }
}

struct OnHover: ViewModifier {
    @State var isHover: Bool = false

    func body(content: Content) -> some View {
        #if os(macOS)
        return content
            .onHover { isHover in withAnimation(.easeInOut) { self.isHover = isHover } }
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.44), radius: isHover ? 6 : 0)
            .scaleEffect(isHover ? 1.1 : 1)
        #else
        return content
        #endif
    }
}

#if DEBUG
struct Arms_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ZStack {
            Circle().stroke()
            Arms()
        }
        .padding()
        .environment(\.clockDate, .constant(.init(hour: 10, minute: 10, calendar: calendar)))
    }
}
#endif
