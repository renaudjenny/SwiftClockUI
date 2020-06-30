import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ArmTests: XCTestCase {
  func testMinuteArms() {
    let arms = ArmMinute_Previews.previews.environment(\.clockIsAnimationEnabled, false)
    assertSnapshot(matching: arms, as: .defaultImage)
  }

  func testHourArm() {
    let arms = ArmHour_Previews.previews.environment(\.clockIsAnimationEnabled, false)
    let hostingController = UIHostingController(rootView: arms)
    assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
  }

  func testArmWith25MinuteAngle() {
    let arms = ArmWith25MinuteAngle_Previews.previews.environment(\.clockIsAnimationEnabled, false)
    let hostingController = UIHostingController(rootView: arms)
    assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
  }

  func testArtNouveauArm() {
    let arms = ArtNouveauDesignArm_Previews.previews.environment(\.clockIsAnimationEnabled, false)
    let hostingController = UIHostingController(rootView: arms)
    assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
  }

  func testDrawningArm() {
    let arms = DrawingDesignArm_Previews.previews
        .environment(\.clockIsAnimationEnabled, false)
        .environment(\.clockRandom, .fixed)
    let hostingController = UIHostingController(rootView: arms)
    assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
  }

  func testDrawnArms() {
    let arms = DrawnArm_Previews.previews
        .environment(\.clockIsAnimationEnabled, false)
        .environment(\.clockRandom, .fixed)
    let hostingController = UIHostingController(rootView: arms)
    assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
  }
}
