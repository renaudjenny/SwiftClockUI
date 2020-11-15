import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class CogwheelKeyTests: XCTestCase {
    #if !os(macOS)
    func testCogwheel() {
        let arms = Cogwheel_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: arms)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }

    func testCogwheels() {
        let arms = Cogwheels_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: arms)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }
    #endif
}
