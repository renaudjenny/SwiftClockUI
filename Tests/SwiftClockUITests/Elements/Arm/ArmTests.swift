import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ArmTests: XCTestCase {
    #if !os(macOS)
    func testMinuteArms() {
        let arms = ArmMinute_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: arms, as: .default)
    }

    func testHourArm() {
        let arms = ArmHour_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: arms, as: .default)
    }

    func testArmWith25MinuteAngle() {
        let arms = ArmWith25MinuteAngle_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: arms, as: .default)
    }

    func testArtNouveauArm() {
        let arms = ArtNouveauDesignArm_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: arms, as: .default)
    }

    func testDrawningArm() {
        let arms = DrawingDesignArm_Previews.previews
            .environment(\.clockIsAnimationEnabled, false)
            .environment(\.clockRandom, .fixed)
        assertSnapshot(matching: arms, as: .default)
    }

    func testDrawnArms() {
        let arms = DrawnArm_Previews.previews
            .environment(\.clockIsAnimationEnabled, false)
            .environment(\.clockRandom, .fixed)
        assertSnapshot(matching: arms, as: .default)
    }
    #endif
}
