import SwiftUI

struct SteampunkIndicators: View {
    @Environment(\.clockConfiguration) var configuration
    static let marginRatio: CGFloat = 1/5
    static let decorationScale: CGFloat = 7/10
    static let lineWidthRatio: CGFloat = 1/100
    static let decorationLineWidthRatio: CGFloat = lineWidthRatio * 1/decorationScale
    @State private var frame: CGRect = .zero

    var body: some View {
        ZStack {
            ZStack {
                mainCogwheel
                moon
                Gears(strokeLineWidth: frame.radius * Self.decorationLineWidthRatio).mask(moon)
            }.scaleEffect(Self.decorationScale)
            circles
            numbers
        }.modifier(LocalFrameProvider(frame: $frame))
    }

    private var mainCogwheel: some View {
        Cogwheel()
            .scale(0.8)
            .stroke(lineWidth: frame.radius * Self.decorationLineWidthRatio)
            .modifier(RotateOnAppear())
    }

    private var circles: some View {
        ZStack {
            Circle()
                .scale(21/25)
                .stroke(lineWidth: frame.radius * Self.lineWidthRatio)
            Circle()
                .scale(20/25)
                .stroke(lineWidth: frame.radius * Self.lineWidthRatio)
        }
    }

    private var moon: some View {
        ZStack {
            Moon().fill(Color.background)
            Moon().stroke(lineWidth: frame.radius * Self.decorationLineWidthRatio)
        }.modifier(BalanceOnAppear())
    }

    private var numbers: some View {
        ForEach(RomanNumber.numbers(configuration: configuration), id: \.self) { romanNumber in
            Plate(type: self.plateType(for: romanNumber), text: romanNumber)
                .scaleEffect(3/19)
                .modifier(PositionInCircle(angle: RomanNumber.angle(for: romanNumber), marginRatio: Self.marginRatio))
        }
    }

    private func plateType(for romanNumber: String) -> Plate.PlateType {
        RomanNumber.limitedNumbers.contains(romanNumber) ? .hard : .soft
    }
}

struct Gears: View {
    let strokeLineWidth: CGFloat
    @State private var circle: CGRect = .zero

    var body: some View {
        Group {
            Cogwheel(toothCount: 12, armCount: 3, addExtraHoles: false)
                .scale(1/5)
                .stroke(lineWidth: strokeLineWidth)
                .modifier(RotateOnAppear(clockwise: false))
                .position(gearsPositions.first)
            Cogwheel(toothCount: 8, armCount: 5, addExtraHoles: false)
                .scale(1/6)
                .fill(style: .init(eoFill: true, antialiased: true))
                .modifier(RotateOnAppear(clockwise: true))
                .position(gearsPositions.second)
            Cogwheel(toothCount: 12, armCount: 8, addExtraHoles: false)
                .scale(1/4)
                .stroke(lineWidth: strokeLineWidth)
                .modifier(RotateOnAppear(clockwise: false))
                .position(gearsPositions.third)
        }
        .modifier(LocalFrameProvider(frame: $circle))
    }

    private var gearsPositions: (first: CGPoint, second: CGPoint, third: CGPoint) {(
        CGPoint(
            x: circle.midX - circle.radius * 4/5,
            y: circle.midY + circle.radius * 1/4
        ),
        CGPoint(
            x: circle.midX - circle.radius * 2/4,
            y: circle.midY + circle.radius * 4/10
        ),
        CGPoint(
            x: circle.midX - circle.radius * 1/4,
            y: circle.midY + circle.radius * 7/10
        )
    )}
}

struct SteampunkIndicators_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            SteampunkIndicators()
        }.padding()
    }
}

struct SteampunkIndicatorsWithLimitedHours_Previews: PreviewProvider {
    static var customClockConfiguration = ClockConfiguration(
        isLimitedHoursShown: true,
        isMinuteIndicatorsShown: true,
        isHourIndicatorsShown: true
    )

    static var previews: some View {
        ZStack {
            Circle().stroke()
            SteampunkIndicators().environment(\.clockConfiguration, customClockConfiguration)
        }.padding()
    }
}
