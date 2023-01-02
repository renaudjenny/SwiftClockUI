import SwiftUI
import SnapshotTesting

#if !os(macOS)
extension Snapshotting where Value: SwiftUI.View, Format == UIImage {
    static func `default`(precision: Float) -> Self {
        image(precision: precision, layout: .fixed(width: 200, height: 200))
    }
    static var `default`: Self { .default(precision: 1) }
}
#endif
