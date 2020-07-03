import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI
import Combine

class ClockTests: XCTestCase {
    func testDefaultClockView() {
        let clockViews = ClockView_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: clockViews, as: .default)
    }

    func testClockViewWithFace() {
        let clockViews = ClockViewWithFace_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: clockViews, as: .default)
    }

    func testClockViewArtNouveauStyle() {
        let clockViews = ClockViewArtNouveauStyle_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: clockViews, as: .default)
    }

    func testClockViewDrawingStyle() {
        let clockViews = ClockViewDrawingStyle_Previews.previews
            .environment(\.clockIsAnimationEnabled, false)
            .environment(\.clockRandom, .fixed)
        assertSnapshot(matching: clockViews, as: .default)
    }

    func testClockViewSteampunkStyle() {
        let clockViews = ClockViewSteampunkStyle_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: clockViews, as: .default)
    }

    func testClockViewDifferentColors() {
        let clockViews = ClockViewDifferentColors_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: clockViews, as: .default)
    }
}
