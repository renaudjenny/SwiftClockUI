import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ClockFaceTests: XCTestCase {
    #if !os(macOS)
    func testClockFaceSmiling() {
        let clockFaces = ClockFaceSmiling_Previews.previews
            .environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: clockFaces, as: .default)
    }
    #endif
}
