import SwiftUI

struct FontProportional: ViewModifier {
    let ratio: CGFloat
    var weight = Font.Weight.regular
    var design = Font.Design.default

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .font(.system(size: (geometry.diameter * self.ratio).rounded(), weight: self.weight, design: self.design))
                .minimumScaleFactor(0.5)
        }
    }
}
