import SwiftUI
import SnapshotTesting

#if !os(macOS)
extension Snapshotting where Value: SwiftUI.View, Format == UIImage {
    static var `default`: Self { image(layout: .fixed(width: 200, height: 200)) }
}
#endif
