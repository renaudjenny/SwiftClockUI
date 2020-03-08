import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ClassicClockBorderTests: XCTestCase {
    func testClassicClockBorder() {
        let arms = ClassicClockBorder_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: arms)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }
}
