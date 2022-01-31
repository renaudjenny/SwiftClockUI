import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class PlateTests: XCTestCase {
    #if !os(macOS)
    func testPlate() {
        assertSnapshot(matching: Plate_Previews.previews, as: .default)
    }
    #endif
}
