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
        let preview = SteampunkIndicatorsWithLimitedHours_Previews.previews
        assertSnapshot(matching: preview, as: .default)
    }
    #endif
}
