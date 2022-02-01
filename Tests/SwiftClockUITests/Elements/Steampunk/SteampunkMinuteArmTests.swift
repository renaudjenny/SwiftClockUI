import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class SteampunkMinuteArmTests: XCTestCase {
    #if !os(macOS)
    func testSteampunkMinuteArm() {
        assertSnapshot(matching: SteampunkMinuteArm_Previews.previews, as: .default)
    }
    #endif
}
