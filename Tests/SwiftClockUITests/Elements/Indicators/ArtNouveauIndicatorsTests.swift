import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ArtNouveauIndicatorsTests: XCTestCase {
    #if !os(macOS)
    func testArtNouveauIndicators() {
        let indicators = ArtNouveauIndicators_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: indicators, as: .default)
    }
    #endif
}
