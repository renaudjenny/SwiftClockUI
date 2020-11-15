import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ClassicClockBorderTests: XCTestCase {
    #if !os(macOS)
    func testClassicClockBorder() {
        let clockBorder = ClassicClockBorder_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: clockBorder, as: .default)
    }
    #else
    func testClassicClockBorderOnMac() {
        let clockBorder = ClassicClockBorder_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let view = NSHostingView(rootView: clockBorder)
        view.frame = CGRect(x: 0, y: 0, width: 800, height: 600)
        view.layer?.backgroundColor = .white
        assertSnapshot(matching: view, as: .image)
    }
    #endif
}
