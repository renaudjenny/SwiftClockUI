import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ArmsTests: XCTestCase {
    #if !os(macOS)
    func testArms() {
        assertSnapshot(matching: Arms_Previews.previews, as: .default)
    }
    #endif
}
