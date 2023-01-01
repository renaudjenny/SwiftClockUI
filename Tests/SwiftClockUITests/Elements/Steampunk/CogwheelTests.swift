import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class CogwheelKeyTests: XCTestCase {
    #if !os(macOS)
    func testCogwheel() {
        assertSnapshot(matching: Cogwheel_Previews.previews, as: .default)
    }

    func testCogwheels() {
        assertSnapshot(matching: Cogwheels_Previews.previews, as: .default)
    }
    #endif
}
