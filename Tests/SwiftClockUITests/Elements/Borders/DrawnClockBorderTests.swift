import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class DrawnClockBorderTests: XCTestCase {
    #if !os(macOS)
    func testDrawnClockBorder() {
        let preview = DrawnClockBorder_Previews.previews.environment(\.clockRandom, .fixed)
        assertSnapshot(matching: preview, as: .default)
    }
    #endif
}
