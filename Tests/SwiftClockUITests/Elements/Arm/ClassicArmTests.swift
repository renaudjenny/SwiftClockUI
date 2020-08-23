import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ClassicArmTests: XCTestCase {
    func testClassicArm() {
        let arms = ClassicArm_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: arms, as: .default)
    }
}
