import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class SteampunkMinuteArmTests: XCTestCase {
    #if !os(macOS)
    func testSteampunkMinuteArm() {
        let arms = SteampunkMinuteArm_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: hostingController, as: .default)
    }
    #endif
}
