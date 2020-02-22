import SwiftUI

struct ClockBorderView: View {
    @Environment(\.clockStyle) var style

    var body: some View {
        Group {
            if style == .artNouveau {
                ArtNouveauClockBorder()
            } else if style == .drawing {
                DrawnClockBorder()
            } else {
                ClassicClockBorder()
            }
        }
    }
}
