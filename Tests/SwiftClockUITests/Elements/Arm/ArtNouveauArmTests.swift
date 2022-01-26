import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ArtNouveauArmTests: XCTestCase {
    #if !os(macOS)
    func testArtNouveauArm() {
        assertSnapshot(matching: ArtNouveauArm_Previews.previews, as: .default)
    }
    #endif
}
