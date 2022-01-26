import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ClassicArmTests: XCTestCase {
    #if !os(macOS)
    func testClassicArm() {
        assertSnapshot(matching: ClassicArm_Previews.previews, as: .default)
    }
    #endif
}
