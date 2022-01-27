import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class DrawnClockBorderTests: XCTestCase {
    #if !os(macOS)
    func testDrawnClockBorder() {
        assertSnapshot(
            matching: DrawnClockBorder_Previews.previews.environment(\.clockRandom, .fixed),
            as: .default
        )
    }
    #endif
}
