import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI
import Combine

class ClockTests: XCTestCase {
    func testDefaultClockView() {
        let clockViews = ClockView_Previews.previews.environment(\.clockConfiguration.isAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: clockViews)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe), record: true)
    }
}
