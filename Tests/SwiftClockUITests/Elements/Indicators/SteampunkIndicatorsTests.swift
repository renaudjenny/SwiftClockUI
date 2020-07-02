import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class SteampunkIndicatorsTests: XCTestCase {
    func testSteampunkIndicators() {
        let indicators = SteampunkIndicators_Previews.previews
            .environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: indicators, as: .defaultImage)
    }

    func testSteampunkIndicatorsWithLimitedHours() {
        let indicators = SteampunkIndicatorsWithLimitedHours_Previews.previews
            .environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: indicators, as: .defaultImage)
    }
}
