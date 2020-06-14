import SwiftUI

struct ClockBorderView: View {
    @Environment(\.clockStyle) var style
    @Environment(\.clockBorderColor) var color

    var body: some View {
        Group {
            if style == .artNouveau {
                ArtNouveauClockBorder()
            } else if style == .drawing {
                DrawnClockBorder()
            } else if style == .steampunk {
                SteampunkClockBorder()
            } else {
                ClassicClockBorder()
            }
        }.foregroundColor(color)
    }
}
