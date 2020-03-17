import SwiftUI

extension Shape {
    func strokeProportionaly(_ ratio: CGFloat) -> some View {
        GeometryReader { geometry in
            self.stroke(lineWidth: geometry.diameter * ratio)
        }
    }
}
