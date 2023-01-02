import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI
import Combine

class ClockTests: XCTestCase {
    #if !os(macOS)
    func testDefaultClockView() {
        assertSnapshot(matching: ClockView_Previews.previews, as: .default)
    }

    func testClockViewWithFace() {
        assertSnapshot(matching: ClockViewWithFace_Previews.previews, as: .default)
    }

    func testClockViewArtNouveauStyle() {
        assertSnapshot(matching: ClockViewArtNouveauStyle_Previews.previews, as: .default)
    }

    func testClockViewDrawingStyle() {
        let preview = ClockViewDrawingStyle_Previews.previews
            .environment(\.clockRandom, .fixed)
            .environment(\.clockAnimationEnabled, false)
        assertSnapshot(matching: preview, as: .default(precision: 99/100))
    }

    func testClockViewSteampunkStyle() {
        assertSnapshot(matching: ClockViewSteampunkStyle_Previews.previews, as: .default)
    }

    func testClockViewDifferentColors() {
        assertSnapshot(matching: ClockViewDifferentColors_Previews.previews, as: .default)
    }
    #endif
}
