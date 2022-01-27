import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ArtNouveauIndicatorsTests: XCTestCase {
    #if !os(macOS)
    func testArtNouveauIndicators() {
        assertSnapshot(matching: ArtNouveauIndicators_Previews.previews, as: .default)
    }
    #endif
}
