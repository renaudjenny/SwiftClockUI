import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class SteampunkHourArmTests: XCTestCase {
    #if !os(macOS)
    func testSteampunkHourArm() {
        let arms = SteampunkHourArm_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: arms)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }
    #endif
}
