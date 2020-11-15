import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class WindUpKeyTests: XCTestCase {
    #if !os(macOS)
    func testWindUpKey() {
        let arms = WindUpKey_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: arms, as: .default)
    }
    #endif
}
