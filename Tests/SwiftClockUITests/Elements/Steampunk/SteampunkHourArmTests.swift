import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class SteampunkHourArmTests: XCTestCase {
    #if !os(macOS)
    func testSteampunkHourArm() {
        assertSnapshot(
            matching: UIHostingController(rootView: SteampunkHourArm_Previews.previews),
            as: .image(on: .iPhoneSe)
        )
    }
    #endif
}
