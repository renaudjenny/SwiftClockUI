import SwiftUI

extension GeometryProxy {
    var radius: CGFloat { min(self.size.width, self.size.height)/2 }
    var circle: CGRect { frame(in: .local) }
}
