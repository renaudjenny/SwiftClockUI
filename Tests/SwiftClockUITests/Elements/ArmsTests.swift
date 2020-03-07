import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ArmsTests: XCTestCase {
    func testArms() {
        let arms = Arms_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: arms)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }
}
