import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class SteampunkIndicatorsTests: XCTestCase {
    #if !os(macOS)
    func testSteampunkIndicators() {
        assertSnapshot(matching: SteampunkIndicators_Previews.previews, as: .default)
    }

    func testSteampunkIndicatorsWithLimitedHours() {
        assertSnapshot(
            matching: SteampunkIndicatorsWithLimitedHours_Previews.previews,
            as: .default
        )
    }
    #endif
}
