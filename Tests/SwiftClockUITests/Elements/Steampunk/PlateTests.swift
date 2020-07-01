import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class PlateTests: XCTestCase {
    func testPlate() {
        let plates = Plate_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: plates, as: .defaultImage)
    }
}
