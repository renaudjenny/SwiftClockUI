import SwiftUI

struct ArtNouveauIndicators: View {
    @Environment(\.clockConfiguration) var configuration
    static let marginRatio: CGFloat = 1/12
    private static let textFontRatio: CGFloat = 1/8
    @State private var numberCircleRadius: CGFloat = .zero

    var body: some View {
        ZStack {
            ForEach(RomanNumber.numbers(configuration: configuration), id: \.self) { romanNumber in
                self.romanHour(for: romanNumber)
            }
            if configuration.isMinuteIndicatorsShown {
                Sun()
                    .stroke()
                    .modifier(ScaleUpOnAppear())
            }
        }
    }

    func romanHour(for romanNumber: String) -> some View {
        Text(romanNumber)
            .modifier(NumberInCircle(radius: numberCircleRadius))
            .modifier(RadiusProvider(radius: $numberCircleRadius))
            .modifier(PositionInCircle(
                angle: RomanNumber.angle(for: romanNumber),
                marginRatio: Self.marginRatio * 2
            ))
            .modifier(FontProportional(ratio: Self.textFontRatio))
            .modifier(ScaleUpOnAppear())
    }

    private struct NumberInCircle: ViewModifier {
        var radius: CGFloat

        func body(content: Content) -> some View {
            content
                .background(background)
                .overlay(overlay)
        }

        private var background: some View {
            Circle()
                .fill(Color.background)
                .frame(width: radius * 3, height: radius * 3)
        }

        private var overlay: some View {
            Circle()
                .stroke()
                .frame(width: radius * 3, height: radius * 3)
        }
    }

    private struct Sun: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let circle = rect
            let startPoint = CGPoint.inCircle(circle, for: .zero, margin: circle.radius * 1/3)
            path.move(to: startPoint)

            for minute in 1...60 {
                let point = CGPoint.inCircle(
                    circle,
                    for: Angle(degrees: Double(minute) * 6),
                    margin: circle.radius * 1/3
                )

                let control = CGPoint.inCircle(
                    circle,
                    for: Angle(degrees: Double(minute) * 6 - 3),
                    margin: circle.radius * 1/2
                )

                path.addQuadCurve(to: point, control: control)
            }

            return path
        }
    }
}

#if DEBUG
struct ArtNouveauIndicators_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArtNouveauIndicators()
        }.padding()
    }
}
#endif
