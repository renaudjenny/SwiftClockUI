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
//                withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
//                    clowiseRotationAngle += .fullRound
//                    counterClockwiseRotationAngle += -.fullRound
//                }
            }
    }

    private func content(geometry: GeometryProxy) -> some View {
        ZStack {
            ZStack {
                mainCogwheel(geometry: geometry)
                moon(geometry: geometry)
                gears(strokeLineWidth: geometry.radius * Self.decorationLineWidthRatio).mask(moon(geometry: geometry))
            }.scaleEffect(Self.decorationScale)
            circles(geometry: geometry)
            numbers
        }
    }

    private func mainCogwheel(geometry: GeometryProxy) -> some View {
        Cogwheel()
            .scale(0.8)
            .stroke(lineWidth: geometry.radius * Self.decorationLineWidthRatio)
            .rotationEffect(clowiseRotationAngle)
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

    private func gears(strokeLineWidth: CGFloat) -> some View {
        GeometryReader { geometry in
            Group {
                Cogwheel(toothCount: 12, armCount: 3, addExtraHoles: false)
                    .scale(1/5)
                    .stroke(lineWidth: strokeLineWidth)
                    .rotationEffect(counterClockwiseRotationAngle)
                    .position(GearPosition.first.position(geometry: geometry))
                Cogwheel(toothCount: 8, armCount: 5, addExtraHoles: false)
                    .scale(1/6)
                    .fill(style: .init(eoFill: true, antialiased: true))
                    .rotationEffect(clowiseRotationAngle)
                    .position(GearPosition.second.position(geometry: geometry))
                Cogwheel(toothCount: 12, armCount: 8, addExtraHoles: false)
                    .scale(1/4)
                    .stroke(lineWidth: strokeLineWidth)
                    .rotationEffect(counterClockwiseRotationAngle)
                    .position(GearPosition.third.position(geometry: geometry))
            }
        }
    }

    private enum GearPosition {
        case first, second, third

        func position(geometry: GeometryProxy) -> CGPoint {
            switch self {
            case .first: return CGPoint(
                x: geometry.frame(in: .local).midX - geometry.radius * 4/5,
                y: geometry.frame(in: .local).midY + geometry.radius * 1/4
                )
            case .second: return CGPoint(
                x: geometry.frame(in: .local).midX - geometry.radius * 2/4,
                y: geometry.frame(in: .local).midY + geometry.radius * 4/10
                )
            case .third: return CGPoint(
                x: geometry.frame(in: .local).midX - geometry.radius * 1/4,
                y: geometry.frame(in: .local).midY + geometry.radius * 7/10
                )
            }
        }
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
