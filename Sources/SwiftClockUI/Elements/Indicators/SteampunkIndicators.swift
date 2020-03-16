import SwiftUI

struct SteampunkIndicators: View {
    var body: some View {
        ZStack() {
            mainCogwheel
            circles
            moon
            gears.mask(moon)
        }
        .aspectRatio(1/1, contentMode: .fit)
    }

    private var mainCogwheel: some View {
        Cogwheel()
            .stroke()
            .scale(0.8)
            .modifier(RotateOnAppear())
    }

    private var circles: some View {
        ZStack() {
            Circle()
                .stroke()
                .scale(29/30)
            Circle()
                .scale(28/30)
                .stroke()
        }
    }

    private var moon: some View {
        ZStack {
            Moon().stroke()
            Moon().fill(Color.background)
        }.modifier(BalanceOnAppear())
    }

    private var gears: some View {
        GeometryReader { geometry in
            Cogwheel(toothCount: 12, armCount: 3, addExtraHoles: false)
                .scale(1/5)
                .stroke()
                .modifier(RotateOnAppear(clockwise: false))
                .position(x: geometry.diameter * 1/10, y: geometry.diameter * 10/15)
            Cogwheel(toothCount: 8, armCount: 5, addExtraHoles: false)
                .scale(1/6)
                .fill(style: .init(eoFill: true, antialiased: true))
                .modifier(RotateOnAppear(clockwise: true))
                .position(x: geometry.diameter * 7/29, y: geometry.diameter * 7/9)
            Cogwheel(toothCount: 12, armCount: 8, addExtraHoles: false)
                .scale(1/4)
                .stroke()
                .modifier(RotateOnAppear(clockwise: false))
                .position(x: geometry.diameter * 2/5, y: geometry.diameter * 9/10)
        }
    }
}

struct SteampunkIndicators_Previews: PreviewProvider {
    static var previews: some View {
        SteampunkIndicators().padding()
    }
}
