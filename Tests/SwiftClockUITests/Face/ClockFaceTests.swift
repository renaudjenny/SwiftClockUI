import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ClockFaceTests: XCTestCase {
    #if !os(macOS)
    func testClockFaceSmiling() {
        assertSnapshot(matching: ClockFaceSmiling_Previews.previews, as: .default)
    }
    #endif
}
