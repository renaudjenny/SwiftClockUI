import SwiftUI

extension Shape {
    func strokeProportionally(_ ratio: CGFloat) -> some View {
        GeometryReader { geometry in
            self.stroke(lineWidth: geometry.radius * ratio)
        }
    }
}
