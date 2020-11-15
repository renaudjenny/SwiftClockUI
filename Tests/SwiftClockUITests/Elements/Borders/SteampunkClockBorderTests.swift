import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class SteampunkClockBorderTests: XCTestCase {
    #if !os(macOS)
    func testSteampunkClockBorderBorder() {
        let borders = SteampunkClockBorder_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: borders, as: .default)
    }
    #endif
}
