import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class EyeTests: XCTestCase {
    #if !os(macOS)
    func testEyes() {
        assertSnapshot(matching: Eye_Previews.previews, as: .default)
    }
    #endif
}
