import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class EyeTests: XCTestCase {
  func testEyes() {
    let eyes = Eye_Previews.previews
    let hostingController = UIHostingController(rootView: eyes)
    assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
  }
}
