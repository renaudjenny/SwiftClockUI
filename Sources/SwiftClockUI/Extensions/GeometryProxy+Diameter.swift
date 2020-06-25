import SwiftUI

extension GeometryProxy {
    var radius: CGFloat { min(size.width, size.height)/2 }
    var circle: CGRect { frame(in: .local) }
}
