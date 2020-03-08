import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ClassicArmTests: XCTestCase {
    func testClassicArm() {
        let arms = ClassicArm_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: arms)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }
}
