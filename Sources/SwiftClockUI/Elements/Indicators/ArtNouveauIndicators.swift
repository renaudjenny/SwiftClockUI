import SwiftUI

struct ArtNouveauIndicators: View {
    @Environment(\.clockConfiguration) var configuration
    static let marginRatio: CGFloat = 1/12
    private static let textFontRatio: CGFloat = 1/8

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
        }.aspectRatio(contentMode: .fit)
    }

    func romanHour(for romanNumber: String) -> some View {
        GeometryReader { geometry in
            Text(romanNumber)
                .modifier(FontProportional(ratio: Self.textFontRatio))
                .modifier(NumberCircle(geometry: geometry))
                .modifier(ScaleUpOnAppear())
                .modifier(PositionInCircle(angle: RomanNumber.angle(for: romanNumber), marginRatio: Self.marginRatio * 2))
        }
    }

    private struct NumberCircle: ViewModifier {
        let geometry: GeometryProxy

        func body(content: Content) -> some View {
            content
                .background(self.background)
                .overlay(self.overlay)
        }

        private var width: CGFloat {
            geometry.radius * 3 * ArtNouveauIndicators.marginRatio
        }

        private var background: some View {
            Circle()
                .fill(Color.background)
                .frame(width: width, height: width)
        }

        private var overlay: some View {
            Circle()
                .stroke()
                .frame(width: width, height: width)
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
