import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class EyeTests: XCTestCase {
    #if !os(macOS)
    func testEyes() {
        let eyes = Eye_Previews.previews
            .environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: eyes, as: .default)
    }
    #endif
}
