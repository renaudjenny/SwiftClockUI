import SwiftUI
import Combine

public struct ClockView: View {
    @Environment(\.clockFaceShown) var initialClockFaceShown
    static let borderWidthRatio: CGFloat = 1/70
    @State private var clockFaceShown = false

    public init() { }

    public var body: some View {
        ZStack {
            ClockBorderView()
            IndicatorsView()
            Arms()
            ClockFaceView()
        }
        .environment(\.clockFaceShown, initialClockFaceShown || clockFaceShown)
        .onTapGesture(count: 3, perform: self.showClockFace)
    }

    private func showClockFace() {
        clockFaceShown = true
        _ = Just(false)
            .delay(for: .seconds(3), scheduler: RunLoop.main)
            .sink { self.clockFaceShown = $0 }
    }
}

#if DEBUG
struct ClockView_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ClockView()
            .padding()
            .environment(\.clockDate, .constant(.init(hour: 10, minute: 10, calendar: calendar)))
    }
}

struct ClockViewWithFace_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ClockView()
            .padding()
            .environment(\.clockDate, .constant(.init(hour: 8, minute: 17, calendar: calendar)))
            .environment(\.clockFaceShown, true)
    }
}

struct ClockViewArtNouveauStyle_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ClockView()
            .padding()
            .environment(\.clockDate, .constant(.init(hour: 10, minute: 10, calendar: calendar)))
            .environment(\.clockStyle, .artNouveau)
    }
}

struct ClockViewDrawingStyle_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ClockView()
            .padding()
            .environment(\.clockDate, .constant(.init(hour: 10, minute: 10, calendar: calendar)))
            .environment(\.clockStyle, .drawing)
    }
}

struct ClockViewSteampunkStyle_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ClockView()
            .padding()
            .environment(\.clockDate, .constant(.init(hour: 10, minute: 10, calendar: calendar)))
            .environment(\.clockStyle, .steampunk)
    }
}

struct ClockViewDifferentColors_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ClockView()
            .padding()
            .environment(\.clockDate, .constant(.init(hour: 10, minute: 10, calendar: calendar)))
            .environment(\.clockArmColors, ClockArmColors(
                minute: .red,
                hour: .blue
            ))
            .environment(\.clockBorderColor, .orange)
            .environment(\.clockIndicatorsColor, .green)
    }
}
#endif
