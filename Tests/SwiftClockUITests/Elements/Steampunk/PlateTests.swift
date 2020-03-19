import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class PlateTests: XCTestCase {
    func testPlate() {
        let arms = Plate_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: arms)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }
}
