import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ClassicClockBorderTests: XCTestCase {
    #if !os(macOS)
    func testClassicClockBorder() {
        assertSnapshot(matching: ClassicClockBorder_Previews.previews, as: .default)
    }
    #else
    func testClassicClockBorderOnMac() {
        let view = NSHostingView(rootView: ClassicClockBorder_Previews.previews)
        view.frame = CGRect(x: 0, y: 0, width: 800, height: 600)
        view.layer?.backgroundColor = .white
        assertSnapshot(matching: view, as: .image(precision: 90/100))
    }
    #endif
}
