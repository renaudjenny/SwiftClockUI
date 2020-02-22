import SwiftUI
import Combine

public struct ClockView: View {
    static let borderWidthRatio: CGFloat = 1/70
    @State private var clockFaceShown = false

    public init() { }

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ClockBorderView()
                IndicatorsView()
                Arms()
                ClockFaceView().environment(\.clockFaceShown, self.clockFaceShown)
            }
            .frame(width: geometry.localDiameter, height: geometry.localDiameter)
            .fixedSize()
            .onTapGesture(count: 3, perform: self.showClockFace)
        }
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
        ClockView().padding()
            .environment(\.clockDate, .constant(.init(hour: 10, minute: 10, calendar: calendar)))
    }
}

struct ClockViewWithFace_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ClockView().padding()
            .environment(\.clockDate, .constant(.init(hour: 8, minute: 17, calendar: calendar)))
            .environment(\.clockFaceShown, true)
    }
}

struct ClockViewArtNouveauStyle_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ClockView().padding()
            .environment(\.clockDate, .constant(.init(hour: 10, minute: 10, calendar: calendar)))
            .environment(\.clockStyle, .artNouveau)
    }
}

struct ClockViewDrawingStyle_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ClockView().padding()
            .environment(\.clockDate, .constant(.init(hour: 10, minute: 10, calendar: calendar)))
            .environment(\.clockStyle, .drawing)
    }
}
#endif
