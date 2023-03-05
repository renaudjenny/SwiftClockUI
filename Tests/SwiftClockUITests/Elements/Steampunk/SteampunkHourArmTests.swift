import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class SteampunkHourArmTests: XCTestCase {
    #if !os(macOS)
    func testSteampunkHourArm() {
        assertSnapshot(matching: SteampunkHourArm_Previews.previews, as: .default)
    }
    #endif
}
