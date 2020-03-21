import SwiftUI

struct ArtNouveauIndicators: View {
    @Environment(\.clockConfiguration) var configuration
    static let marginRatio: CGFloat = 1/12
    private static let textFontRatio: CGFloat = 1/16
    
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
                .modifier(PositionInCircle(angle: RomanNumber.angle(for: romanNumber), marginRatio: Self.marginRatio))
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
            geometry.diameter * 3/2 * ArtNouveauIndicators.marginRatio
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
            let diameter = min(rect.width, rect.height)
            
            path.move(to: .pointInCircle(
                from: .zero,
                diameter: diameter,
                margin: rect.width/6
                ))
            
            for minute in 1...60 {
                let point: CGPoint = .pointInCircle(
                    from: Angle(degrees: Double(minute) * 6),
                    diameter: diameter,
                    margin: rect.width/6
                )
                
                let control: CGPoint = .pointInCircle(
                    from: Angle(degrees: Double(minute) * 6 - 3),
                    diameter: diameter,
                    margin: rect.width/4
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
