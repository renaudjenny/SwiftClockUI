import SwiftUI

struct ArtNouveauIndicators: View {
    @Environment(\.clockConfiguration) var configuration
    static let marginRatio: CGFloat = 1/12
    private static let hourInDegree: Double = 30
    private static let romanNumbers = ["XII", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI"]
    private static let limitedRomanNumbers = ["XII", "III", "VI", "IX"]
    private static let textScaleRatio: CGFloat = 1/256
    
    var body: some View {
        ZStack {
            ForEach(configurationRomanNumbers, id: \.self) { romanNumber in
                self.romanHour(for: romanNumber)
            }
            if configuration.isMinuteIndicatorsShown {
                Sun()
                    .stroke()
                    .modifier(ScaleUpOnAppear())
            }
        }.aspectRatio(1/1, contentMode: .fit)
    }
    
    func romanHour(for romanNumber: String) -> some View {
        GeometryReader { geometry in
            Text(romanNumber)
                .modifier(ScaleProportional(ratio: Self.textScaleRatio))
                .modifier(NumberCircle(geometry: geometry))
                .modifier(ScaleUpOnAppear())
                .modifier(PositionInCircle(angle: self.angle(for: romanNumber), marginRatio: Self.marginRatio))
        }
    }
    
    private var configurationRomanNumbers: [String] {
        configuration.isLimitedHoursShown ? Self.limitedRomanNumbers : Self.romanNumbers
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
    
    private func angle(for romanNumber: String) -> Angle {
        guard let index = Self.romanNumbers.firstIndex(of: romanNumber) else { return .zero }
        return Angle(degrees: Double(index) * Self.hourInDegree)
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
