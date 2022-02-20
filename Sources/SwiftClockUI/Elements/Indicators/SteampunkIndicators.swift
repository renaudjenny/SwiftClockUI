import SwiftUI

struct SteampunkIndicators: View {
    @Environment(\.clockConfiguration) var configuration
    static let marginRatio: CGFloat = 1/5
    static let decorationScale: CGFloat = 7/10
    static let lineWidthRatio: CGFloat = 1/100
    static let decorationLineWidthRatio: CGFloat = lineWidthRatio * 1/decorationScale

    @State private var clowiseRotationAngle: Angle = .zero
    @State private var counterClockwiseRotationAngle: Angle = .zero

    var body: some View {
        GeometryReader(content: content)
            .onAppear {
                DispatchQueue.main.async {
                    withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                        clowiseRotationAngle += .fullRound
                        counterClockwiseRotationAngle += -.fullRound
                    }
                }
            }
    }

    private func content(geometry: GeometryProxy) -> some View {
        ZStack {
            ZStack {
                mainCogwheel(geometry: geometry)
                moon(geometry: geometry)
                gears().mask(moon(geometry: geometry))
            }.scaleEffect(Self.decorationScale)
            circles(geometry: geometry)
            numbers
        }
    }

    private func mainCogwheel(geometry: GeometryProxy) -> some View {
        Cogwheel(angle: clowiseRotationAngle)
            .scale(0.8)
            .stroke(lineWidth: geometry.radius * Self.decorationLineWidthRatio)
    }

    private func circles(geometry: GeometryProxy) -> some View {
        ZStack {
            Circle()
                .scale(21/25)
                .stroke(lineWidth: geometry.radius * Self.lineWidthRatio)
            Circle()
                .scale(20/25)
                .stroke(lineWidth: geometry.radius * Self.lineWidthRatio)
        }
    }

    private func moon(geometry: GeometryProxy) -> some View {
        ZStack {
            Moon().fill(Color.background)
            Moon().stroke(lineWidth: geometry.radius * Self.decorationLineWidthRatio)
        }
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
                )
            ],
            angle: clowiseRotationAngle
        ).stroke()
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
