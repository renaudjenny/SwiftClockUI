import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class CogwheelKeyTests: XCTestCase {
    #if !os(macOS)
    func testCogwheel() {
        assertSnapshot(
            matching: UIHostingController(rootView: Cogwheel_Previews.previews),
            as: .image(on: .iPhoneSe, precision: 99/100)
        )
    }

    func testCogwheels() {
        assertSnapshot(
            matching: UIHostingController(rootView: Cogwheels_Previews.previews),
            as: .image(on: .iPhoneSe, precision: 99/100)
        )
    }
    #endif
}
