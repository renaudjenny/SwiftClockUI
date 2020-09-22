import SwiftUI
import SnapshotTesting

extension Snapshotting where Value: SwiftUI.View, Format == UIImage {
    static var `default`: Self {
        image(precision: 95/100, layout: .device(config: .iPhoneSe))
    }
}
