import SwiftUI

extension GeometryProxy {
    var diameter: CGFloat { min(self.size.width, self.size.height) }
}
