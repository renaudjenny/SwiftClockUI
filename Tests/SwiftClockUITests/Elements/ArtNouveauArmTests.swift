import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ArtNouveauArmTests: XCTestCase {
    func testArtNouveauArm() {
        let arms = ArtNouveauArm_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        let hostingController = UIHostingController(rootView: arms)
        assertSnapshot(matching: hostingController, as: .image(on: .iPhoneSe))
    }
}
