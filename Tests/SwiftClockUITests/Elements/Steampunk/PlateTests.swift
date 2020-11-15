import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class PlateTests: XCTestCase {
    #if !os(macOS)
    func testPlate() {
        let plates = Plate_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: plates, as: .default)
    }
    #endif
}
