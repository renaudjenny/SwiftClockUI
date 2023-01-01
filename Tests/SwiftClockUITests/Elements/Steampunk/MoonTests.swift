import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class MoonTests: XCTestCase {
    #if !os(macOS)
    func testMoon() {
        assertSnapshot(matching: Moon_Previews.previews, as: .default)
    }
    #endif
}
