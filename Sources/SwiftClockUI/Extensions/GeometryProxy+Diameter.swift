import SwiftUI

extension GeometryProxy {
    // TODO: remove diameter and use radius only
    var diameter: CGFloat { min(self.size.width, self.size.height) }
    var radius: CGFloat { diameter/2 }
    var circle: CGRect { frame(in: .local) }
}
