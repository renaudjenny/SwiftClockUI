import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ArtNouveauArmTests: XCTestCase {
    #if !os(macOS)
    func testArtNouveauArm() {
        let arms = ArtNouveauArm_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: arms, as: .default)
    }
    #endif
}
