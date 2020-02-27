import SwiftUI
import Combine

struct ArmView: View {
    @Environment(\.calendar) var calendar
    @Environment(\.clockDate) var date
    @Environment(\.clockStyle) var style
    @State private var dragAngle: Angle = .zero
    @State private var isDragging = false
    private static let hourRelationship: Double = 360/12
    private static let minuteRelationsip: Double = 360/60
    let type: ArmType

    var body: some View {
        arm
            .modifier(ArmDragGesture(dragAngle: $dragAngle, isDragging: $isDragging, setAngle: setAngle))
            .rotationEffect(rotationAngle)
            // TODO: fix this bumping animation on iOS
            .animation(bumpFreeSpring)
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
        isDragging ? dragAngle : angle
    }

    private var bumpFreeSpring: Animation? {
        isDragging ? nil : .spring()
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
