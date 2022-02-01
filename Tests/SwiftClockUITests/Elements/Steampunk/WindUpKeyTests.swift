import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class WindUpKeyTests: XCTestCase {
    #if !os(macOS)
    func testWindUpKey() {
        assertSnapshot(matching: WindUpKey_Previews.previews, as: .default)
    }
    #endif
}
