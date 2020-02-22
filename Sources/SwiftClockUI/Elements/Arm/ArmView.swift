import SwiftUI

struct ArmView: View {
    @EnvironmentObject var viewModel: AnyArmViewModel
    @Environment(\.calendar) var calendar
    @GestureState private var dragAngle: Angle = .zero
    private static let widthRatio: CGFloat = 1/50
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
        .onAppear(perform: self.setupAngle)
    }

    private var angle: Angle {
        switch type {
        case .hour: return viewModel.hourAngle
        case .minute: return viewModel.minuteAngle
        }
    }

    private func setAngle(_ angle: Angle) {
        switch self.type {
        case .hour: viewModel.hourAngle = angle
        case .minute: viewModel.minuteAngle = angle
        }
        viewModel.setDateFromAngle(type: self.type, calendar: calendar)
    }

    private var arm: some View {
        Group {
            if viewModel.clockStyle == .artNouveau {
                ArtNouveauArm(type: self.type)
            } else if viewModel.clockStyle == .drawing {
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

    private func setupAngle() {
        let date = viewModel.date
        switch self.type {
        case .hour: viewModel.hourAngle = .fromHour(date: date, calendar: calendar)
        case .minute: viewModel.minuteAngle = .fromMinute(date: date, calendar: calendar)
        }
    }
}

// MARK: - Drag Gesture
extension ArmView {
    private func angle(dragGestureValue: DragGesture.Value, frame: CGRect) -> Angle {
        let radius = min(frame.size.width, frame.size.height)/2
        let location = (
            x: dragGestureValue.location.x - radius - frame.origin.x,
            y: -(dragGestureValue.location.y - radius - frame.origin.y)
        )
        let arctan = atan2(location.x, location.y)
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

public protocol ArmViewModel {
    var date: Date { get }
    var hourAngle: Angle { get set }
    var minuteAngle: Angle { get set }
    var clockStyle: ClockStyle { get }
}

final class AnyArmViewModel: ObservableObject, ArmViewModel {
    @Published private(set) var date: Date
    @Published private(set) var clockStyle: ClockStyle
    @Published var hourAngle: Angle
    @Published var minuteAngle: Angle

    init<T: ArmViewModel>(_ viewModel: T) {
        self.date = viewModel.date
        self.hourAngle = viewModel.hourAngle
        self.minuteAngle = viewModel.minuteAngle
        self.clockStyle = viewModel.clockStyle
    }

    private static let hourRelationship: Double = 360/12
    private static let minuteRelationsip: Double = 360/60

    func setDateFromAngle(type: ArmType, calendar: Calendar) {
        switch type {
        case .hour:
            let positiveDegrees = hourAngle.degrees > 0 ? hourAngle.degrees : hourAngle.degrees + 360
            let hour = positiveDegrees/Self.hourRelationship
            let minute = calendar.component(.minute, from: date)
            date = calendar.date(bySettingHour: Int(hour.rounded()), minute: minute, second: 0, of: date) ?? date
        case .minute:
            let positiveDegrees = minuteAngle.degrees > 0 ? minuteAngle.degrees : minuteAngle.degrees + 360
            let minute = positiveDegrees/Self.minuteRelationsip
            let hour = calendar.component(.hour, from: date)
            date = calendar.date(bySettingHour: hour, minute: Int(minute.rounded()), second: 0, of: date) ?? date
        }
    }
}

extension ArmViewModel {
    func eraseToAnyArmViewModel() -> AnyArmViewModel {
        AnyArmViewModel(self)
    }
}

#if DEBUG
struct Arm_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArmView(type: .minute)
        }
        .padding()
        .modifier(PreviewEnvironmentObject())
    }
}

struct BiggerArm_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArmView(type: .hour)
        }
        .padding()
        .modifier(PreviewEnvironmentObject())
    }
}

struct ArmWithAnAngle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArmView(type: .minute)
        }
        .padding()
        .modifier(PreviewEnvironmentObject {
            $0.minuteAngle = .degrees(20)
        })
    }
}

struct ArtNouveauDesignArm_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArmView(type: .minute)
        }
        .padding()
        .modifier(PreviewEnvironmentObject {
            $0.clockStyle = .artNouveau
        })
    }
}

struct DrawingDesignArm_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            ArmView(type: .minute)
        }
        .padding()
        .modifier(PreviewEnvironmentObject {
            $0.clockStyle = .drawing
        })
    }
}
#endif
