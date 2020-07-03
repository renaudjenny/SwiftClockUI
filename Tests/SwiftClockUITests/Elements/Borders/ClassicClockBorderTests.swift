import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ClassicClockBorderTests: XCTestCase {
    func testClassicClockBorder() {
        let clockBorder = ClassicClockBorder_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: clockBorder, as: .default)
    }
}
