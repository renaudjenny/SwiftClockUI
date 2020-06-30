import XCTest
@testable import SwiftClockUI
import SnapshotTesting
import SwiftUI

class ArtNouveauIndicatorsTests: XCTestCase {
    func testArtNouveauIndicators() {
        let indicators = ArtNouveauIndicators_Previews.previews.environment(\.clockIsAnimationEnabled, false)
        assertSnapshot(matching: indicators, as: .wait(for: 1.4, on: .defaultImage))
    }
}
