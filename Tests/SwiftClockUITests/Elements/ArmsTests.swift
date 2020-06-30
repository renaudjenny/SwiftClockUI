import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ArmsTests: XCTestCase {
    func testArms() {
        let arms = Arms_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: arms, as: .defaultImage)
    }
}
