import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class SteampunkClockBorderTests: XCTestCase {
    func testSteampunkClockBorderBorder() {
        let arms = SteampunkClockBorder_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: arms)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }
}
