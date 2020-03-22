import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI
import Combine

class ClockTests: XCTestCase {
    func testDefaultClockView() {
        let clockViews = ClockView_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: clockViews)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }

    func testClockViewWithFace() {
        let clockViews = ClockViewWithFace_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: clockViews)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }

    func testClockViewArtNouveauStyle() {
        let clockViews = ClockViewArtNouveauStyle_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: clockViews)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }

    func testClockViewDrawingStyle() {
        let clockViews = ClockViewDrawingStyle_Previews.previews
            .environment(\.clockIsAnimationEnabled, false)
            .environment(\.clockRandom, .fixed)
        let hostingController = UIHostingController(rootView: clockViews)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }

    func testClockViewSteampunkStyle() {
        let clockViews = ClockViewSteampunkStyle_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: clockViews)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }
}
