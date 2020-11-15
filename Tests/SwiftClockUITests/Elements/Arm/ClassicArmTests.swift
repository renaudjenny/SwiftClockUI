import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ClassicArmTests: XCTestCase {
    #if !os(macOS)
    func testClassicArm() {
        let arms = ClassicArm_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: arms, as: .default)
    }
    #endif
}
