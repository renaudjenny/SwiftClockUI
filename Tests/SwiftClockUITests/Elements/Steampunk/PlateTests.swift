import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class PlateTests: XCTestCase {
    #if !os(macOS)
    func testPlateSoftI() {
        assertSnapshot(matching: PlateSoftI_Previews.previews, as: .default)
    }
    func testPlateHardXII() {
        assertSnapshot(matching: PlateHardXII_Previews.previews, as: .default)
    }
    #endif
}
