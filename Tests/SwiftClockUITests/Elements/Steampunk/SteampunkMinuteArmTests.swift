import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class SteampunkMinuteArmTests: XCTestCase {
    func testSteampunkMinuteArm() {
        let arms = SteampunkMinuteArm_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: arms)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }
}
