import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class MouthTests: XCTestCase {
  func testMouths() {
    let mouths = Mouth_Previews.previews
    let hostingController = UIHostingController(rootView: mouths)
    assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
  }
}
