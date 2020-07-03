import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class EyeTests: XCTestCase {
  func testEyes() {
    let eyes = Eye_Previews.previews
    assertSnapshot(matching: eyes, as: .default)
  }
}
