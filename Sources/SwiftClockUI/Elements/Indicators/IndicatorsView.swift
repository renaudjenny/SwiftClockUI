import SwiftUI

struct IndicatorsView: View {
    @Environment(\.clockStyle) var style
    @Environment(\.clockIndicatorsColor) var color

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
        }.foregroundColor(color)
    }
}
