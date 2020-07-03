import SwiftUI
import SnapshotTesting

extension Snapshotting where Value: SwiftUI.View, Format == UIImage {
    static var `default`: Self {
        image(layout: .device(config: .iPhoneSe))
    }
}
