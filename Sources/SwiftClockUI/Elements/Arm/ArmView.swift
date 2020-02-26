import SwiftUI
import Combine

struct ArmView: View {
    @Environment(\.calendar) var calendar
    @Environment(\.clockDate) var date
    @Environment(\.clockStyle) var style
    @GestureState private var dragAngle: Angle = .zero
    private static let widthRatio: CGFloat = 1/50
    private static let hourRelationship: Double = 360/12
    private static let minuteRelationsip: Double = 360/60
    let type: ArmType

    var body: some View {
        GeometryReader { geometry in
            self.arm
                .gesture(
                    DragGesture(coordinateSpace: .global).updating(self.$dragAngle) { value, state, _ in
                        state = self.angle(dragGestureValue: value, frame: geometry.frame(in: .global))
                    }
                    .onEnded({
                        let angle = self.angle(dragGestureValue: $0, frame: geometry.frame(in: .global))
                        self.setAngle(angle)
                    })
            )
        }
        .rotationEffect(self.rotationAngle)
        .animation(self.bumpFreeSpring)
    }

    // TODO: clean-up, it's a mess here!
    private var angle: Angle {
        switch type {
        case .hour: return .fromHour(date: date.wrappedValue, calendar: calendar)
        case .minute: return .fromMinute(date: date.wrappedValue, calendar: calendar)
        }
    }

    private func setAngle(_ angle: Angle) {
        let positiveDegrees = angle.degrees > 0 ? angle.degrees : angle.degrees + 360
        switch self.type {
        case .hour:
            let hour = positiveDegrees/Self.hourRelationship
            let minute = calendar.component(.minute, from: date.wrappedValue)
            date.wrappedValue = .init(hour: Int(hour.rounded()), minute: minute, calendar: calendar)
        case .minute:
            let minute = positiveDegrees/Self.minuteRelationsip
            let hour = calendar.component(.hour, from: date.wrappedValue)
            date.wrappedValue = .init(hour: hour, minute: Int(minute.rounded()), calendar: calendar)
        }
    }

    private var arm: some View {
        Group {
            if style == .artNouveau {
                ArtNouveauArm(type: self.type)
            } else if style == .drawing {
                DrawnArm(type: self.type)
            } else {
                ClassicArm(type: self.type)
            }
        }
    }

    private var rotationAngle: Angle {
        dragAngle == .zero ? angle : dragAngle
    }

    private var bumpFreeSpring: Animation? {
        return dragAngle == .zero ? .spring() : nil
    }

    private func ratios(for type: ArmType) -> (lineWidthRatio: CGFloat, marginRatio: CGFloat) {
        switch type {
        case .hour: return (lineWidthRatio: 1/2, marginRatio: 2/5)
        case .minute: return (lineWidthRatio: 1/3, marginRatio: 1/8)
        }
    }
}

// MARK: - Drag Gesture
extension ArmView {
    private func angle(dragGestureValue: DragGesture.Value, frame: CGRect) -> Angle {
        let radius = min(frame.size.width, frame.size.height)/2
        let location = (
            x: dragGestureValue.location.x - radius - frame.origin.x,
            y: dragGestureValue.location.y - radius - frame.origin.y
        )
        #if os(macOS)
        let arctan = atan2(location.x, location.y)
        #else
        let arctan = atan2(location.x, -location.y)
        #endif
        let positiveRadians = arctan > 0 ? arctan : arctan + 2 * .pi
        return Angle(radians: Double(positiveRadians))
    }
}

enum ArmType {
    case hour
    case minute

    typealias Ratio = (lineWidth: CGFloat, margin: CGFloat)
    private static let hourRatio: Ratio = (lineWidth: 1/2, margin: 2/5)
    private static let minuteRatio: Ratio = (lineWidth: 1/3, margin: 1/8)

    var ratio: Ratio {
        switch self {
        case .hour: return Self.hourRatio
        case .minute: return Self.minuteRatio
        }
    }
}

#if DEBUG
struct ArmMinute_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArmView(type: .minute)
        }
        .aspectRatio(1/1, contentMode: .fit)
        .padding()
        .environment(\.clockDate, .constant(.init(hour: 0, minute: 0, calendar: calendar)))
    }
}

struct ArmHour_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArmView(type: .hour)
        }
        .aspectRatio(1/1, contentMode: .fit)
        .padding()
        .environment(\.clockDate, .constant(.init(hour: 0, minute: 0, calendar: calendar)))
    }
}

struct ArmWith25MinuteAngle_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArmView(type: .minute)
        }
        .aspectRatio(1/1, contentMode: .fit)
        .padding()
        .environment(\.clockDate, .constant(.init(hour: 0, minute: 25, calendar: calendar)))
    }
}

struct ArtNouveauDesignArm_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArmView(type: .minute)
        }
        .aspectRatio(1/1, contentMode: .fit)
        .padding()
        .environment(\.clockDate, .constant(.init(hour: 0, minute: 0, calendar: calendar)))
        .environment(\.clockStyle, .artNouveau)
    }
}

struct DrawingDesignArm_Previews: PreviewProvider {
    @Environment(\.calendar) static var calendar

    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArmView(type: .minute)
        }
        .aspectRatio(1/1, contentMode: .fit)
        .padding()
        .environment(\.clockDate, .constant(.init(hour: 0, minute: 0, calendar: calendar)))
        .environment(\.clockStyle, .drawing)
    }
}
#endif
