import SwiftUI
import SnapshotTesting

extension Snapshotting where Value: SwiftUI.View, Format == UIImage {
    static var defaultImage: Self {
        image(layout: .device(config: .iPhoneSe))
    }
}
