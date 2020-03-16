import SwiftUI

struct IndicatorsView: View {
    @Environment(\.clockStyle) var style

    var body: some View {
        Group {
            if style == .artNouveau {
                ArtNouveauIndicators()
            } else if style == .drawing {
                DrawnIndicators()
            } else if style == .steampunk {
                SteampunkIndicators()
            } else {
                ClassicIndicators()
            }
        }
    }
}
