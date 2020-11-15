import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class MouthTests: XCTestCase {
    #if !os(macOS)
    func testMouths() {
        let mouths = Mouth_Previews.previews
        let hostingController = UIHostingController(rootView: mouths)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }
    #endif
}
