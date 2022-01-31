import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class MoonTests: XCTestCase {
    #if !os(macOS)
    func testMoon() {
        assertSnapshot(
            matching: UIHostingController(rootView: Moon_Previews.previews),
            as: .image(on: .iPhoneSe)
        )
    }
    #endif
}
