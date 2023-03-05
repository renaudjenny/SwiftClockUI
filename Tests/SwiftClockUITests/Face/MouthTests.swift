import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class MouthTests: XCTestCase {
    #if !os(macOS)
    func testMouths() {
        assertSnapshot(matching: Mouth_Previews.previews, as: .default)
    }
    #endif
}
