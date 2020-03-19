import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class SteampunkIndicatorsTests: XCTestCase {
    func testSteampunkIndicators() {
        let arms = SteampunkIndicators_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: arms)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }
}
