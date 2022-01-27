import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class SteampunkClockBorderTests: XCTestCase {
    #if !os(macOS)
    func testSteampunkClockBorderBorder() {
        assertSnapshot(matching: SteampunkClockBorder_Previews.previews, as: .default)
    }
    #endif
}
