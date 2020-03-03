import SwiftUI

// TODO: clean-up. All Extensions shouldn't be in the same file
extension Double {
    static let hourInDegree: Double = 360/12
    static let minuteInDegree: Double = 360/60
}

extension Color {
    static var background: Self {
        #if os(iOS)
        return Self(UIColor.systemBackground)
        #else
        return Self(NSColor.windowBackgroundColor)
        #endif
    }
}

extension GeometryProxy {
    var diameter: CGFloat { return min(self.size.width, self.size.height) }
}
