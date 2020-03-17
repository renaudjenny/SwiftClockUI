import SwiftUI

struct SteampunkIndicators: View {
    // TODO: refactor this because there is lot of similarities with ArtNouveauIndicators
    private static let romanNumbers = ["XII", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI"]
    private static let limitedRomanNumbers = ["XII", "III", "VI", "IX"]
    static let marginRatio: CGFloat = 1/10
    static let decorationScale: CGFloat = 7/10
    static let lineWidthRatio: CGFloat = 1/200
    static let decorationLineWidthRatio: CGFloat = lineWidthRatio * 1/decorationScale

    var body: some View {
        ZStack {
            ZStack() {
                mainCogwheel
                moon
                gears.mask(moon)
            }.scaleEffect(Self.decorationScale)
            circles
            numbers
        }.aspectRatio(1/1, contentMode: .fit)
    }

    private var mainCogwheel: some View {
        Cogwheel()
            .scale(0.8)
            .strokeProportionally(Self.decorationLineWidthRatio)
            .modifier(RotateOnAppear())
    }

    private var circles: some View {
        ZStack() {
            Circle()
                .scale(21/25)
                .strokeProportionally(Self.lineWidthRatio)
            Circle()
                .scale(20/25)
                .strokeProportionally(Self.lineWidthRatio)
        }
    }

    private var moon: some View {
        ZStack {
            Moon().fill(Color.background)
            Moon().strokeProportionally(Self.decorationLineWidthRatio)
        }.modifier(BalanceOnAppear())
    }

    private var gears: some View {
        GeometryReader { geometry in
            Cogwheel(toothCount: 12, armCount: 3, addExtraHoles: false)
                .scale(1/5)
                .strokeProportionally(Self.decorationLineWidthRatio)
                .modifier(RotateOnAppear(clockwise: false))
                .position(x: geometry.diameter * 1/10, y: geometry.diameter * 10/15)
            Cogwheel(toothCount: 8, armCount: 5, addExtraHoles: false)
                .scale(1/6)
                .fill(style: .init(eoFill: true, antialiased: true))
                .modifier(RotateOnAppear(clockwise: true))
                .position(x: geometry.diameter * 7/29, y: geometry.diameter * 7/9)
            Cogwheel(toothCount: 12, armCount: 8, addExtraHoles: false)
                .scale(1/4)
                .strokeProportionally(Self.decorationLineWidthRatio)
                .modifier(RotateOnAppear(clockwise: false))
                .position(x: geometry.diameter * 2/5, y: geometry.diameter * 9/10)
        }
    }

    private var numbers: some View {
        ForEach(Self.romanNumbers, id: \.self) { romanNumber in
            Plate(type: self.plateType(for: romanNumber), text: romanNumber)
                .scaleEffect(3/19)
                .modifier(PositionInCircle(angle: self.angle(for: romanNumber), marginRatio: Self.marginRatio))
        }
    }

    private func angle(for romanNumber: String) -> Angle {
        guard let index = Self.romanNumbers.firstIndex(of: romanNumber) else { return .zero }
        return Angle(degrees: Double(index) * .hourInDegree)
    }

    private func plateType(for romanNumber: String) -> Plate.PlateType {
        Self.limitedRomanNumbers.contains(romanNumber) ? .hard : .soft
    }
}

struct SteampunkIndicators_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            SteampunkIndicators()
        }.padding()
    }
}
