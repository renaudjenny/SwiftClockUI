import SwiftUI

struct SteampunkIndicators: View {
    @Environment(\.clockConfiguration) var configuration

    @State private var animationRotationAngle: Angle = .zero

    var body: some View {
        ZStack {
            ZStack {
                Cogwheel(angle: animationRotationAngle).scale(56/100).stroke()
                ZStack {
                    Moon().scale(70/100).fill(Color.background)
                    Moon().scale(70/100).stroke()
                }
                gears().mask(Moon().scale(70/100))
            }
            circles()
            numbers
        }
        .onAppear {
            guard animationRotationAngle == .zero else { return }
            DispatchQueue.main.async {
                withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                    animationRotationAngle += .fullRound
                }
            }
        }
    }

    private func circles() -> some View {
        ZStack {
            Circle().scale(21/25).stroke()
            Circle().scale(20/25).stroke()
        }
    }

    private var numbers: some View {
        ForEach(RomanNumber.numbers(configuration: configuration), id: \.self) { romanNumber in
            Plate(type: self.plateType(for: romanNumber), text: romanNumber)
                .scaleEffect(3/19)
                .modifier(
                    PositionInCircle(angle: RomanNumber.angle(for: romanNumber), marginRatio: 1/5)
                )
        }
    }

    private func plateType(for romanNumber: String) -> Plate.PlateType {
        RomanNumber.limitedNumbers.contains(romanNumber) ? .hard : .soft
    }

    private func gears() -> some View {
        Cogwheels(
            data: [
                .init(
                    cogwheel: (toothCount: 12, armCount: 3),
                    relativeOffset: (x: 11.0/100, y: 61.0/100),
                    scale: 1.0/5
                ),
                .init(
                    cogwheel: (toothCount: 8, armCount: 5),
                    relativeOffset: (x: 26.0/100, y: 71.0/100),
                    scale: 1.0/6,
                    isClockwise: false
                ),
                .init(
                    cogwheel: (toothCount: 12, armCount: 8),
                    relativeOffset: (x: 38.0/100, y: 87.0/100),
                    scale: 1.0/4
                ),
            ],
            angle: animationRotationAngle
        ).scale(70/100).stroke()
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
