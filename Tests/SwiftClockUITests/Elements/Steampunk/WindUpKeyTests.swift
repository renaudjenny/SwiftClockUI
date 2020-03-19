import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class WindUpKeyTests: XCTestCase {
    func testWindUpKey() {
        let arms = WindUpKey_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: arms)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }
}
