import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ArmTests: XCTestCase {
    #if !os(macOS)
    func testMinuteArms() {
        assertSnapshot(matching: ArmMinute_Previews.previews, as: .default)
    }

    func testHourArm() {
        assertSnapshot(matching: ArmHour_Previews.previews, as: .default)
    }

    func testArmWith25MinuteAngle() {
        assertSnapshot(matching: ArmWith25MinuteAngle_Previews.previews, as: .default)
    }

    func testArtNouveauArm() {
        assertSnapshot(matching: ArtNouveauDesignArm_Previews.previews, as: .default)
    }

    func testDrawningArm() {
        assertSnapshot(
            matching: DrawingDesignArm_Previews.previews.environment(\.clockRandom, .fixed),
            as: .default
        )
    }

    func testDrawnArms() {
        assertSnapshot(
            matching: DrawnArm_Previews.previews.environment(\.clockRandom, .fixed),
            as: .default
        )
    }
    #endif
}
