import SwiftUI

struct BalanceOnAppear: ViewModifier {
    @State var rotationAngle: Angle = -.degrees(40)

    func body(content: Content) -> some View {
        content
            .rotationEffect(rotationAngle)
            .animation(animation, value: rotationAngle)
            .onAppear { rotationAngle = .degrees(20) }
    }

    private var animation: Animation {
        Animation.linear(duration: 4).repeatForever(autoreverses: true)
    }
}

struct BalanceOnAppear_Previews: PreviewProvider {
    static var previews: some View {
        Moon()
            .stroke()
            .modifier(BalanceOnAppear())
    }
}
