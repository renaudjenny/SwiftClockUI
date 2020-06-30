import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ClockFaceTests: XCTestCase {
  func testClockFaceSmiling() {
    let clockFaces = ClockFaceSmiling_Previews.previews
    assertSnapshot(matching: clockFaces, as: .defaultImage)
  }
}
