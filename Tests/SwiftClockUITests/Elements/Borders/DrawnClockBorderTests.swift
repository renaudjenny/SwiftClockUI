import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class DrawnClockBorderTests: XCTestCase {
    func testDrawnClockBorder() {
        let arms = DrawnClockBorder_Previews.previews
            .environment(\.clockIsAnimationEnabled, false)
            .environment(\.clockRandom, .fixed)
        let hostingController = UIHostingController(rootView: arms)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }
}
