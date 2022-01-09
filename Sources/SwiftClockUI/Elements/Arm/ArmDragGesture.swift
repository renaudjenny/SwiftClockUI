import SwiftUI

struct ArmDragGesture: ViewModifier {
    @Environment(\.calendar) var calendar
    @Environment(\.clockDate) var date
    @GestureState private var dragAngle: Angle = .zero
    let type: ArmType

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .contentShape(self.contentShape(geometry: geometry))
                .gesture(self.dragGesture(geometry: geometry))
                .rotationEffect(self.dragAngle)
        }
        .aspectRatio(1, contentMode: .fit)
    }

    private func contentShape(geometry: GeometryProxy) -> Path {
        Rectangle().path(in: CGRect(
            x: geometry.frame(in: .local).midX - geometry.size.width/12,
            y: geometry.frame(in: .local).minY,
            width: geometry.size.width/6,
            height: geometry.size.height/1.9
        ))
    }

    private func dragGesture(geometry: GeometryProxy) -> some Gesture {
        DragGesture(coordinateSpace: .global)
            .updating($dragAngle, body: { value, state, _ in
                let extraRotationAngle = angle(
                    dragGestureValue: value,
                    frame: geometry.frame(in: .global)
                )
                state = extraRotationAngle - self.currentAngle
            })
            .onEnded({ value in
                let angle = angle(dragGestureValue: value, frame: geometry.frame(in: .global))
                setAngle(angle)
            })
    }

    private var currentAngle: Angle {
        type.angle(date: date.wrappedValue, calendar: calendar)
    }

    private func angle(dragGestureValue: DragGesture.Value, frame: CGRect) -> Angle {
        let radius = frame.size.width/2
        let location = (
            x: dragGestureValue.location.x - radius - frame.origin.x,
            y: dragGestureValue.location.y - radius - frame.origin.y
        )
        #if os(macOS)
        let arctan = atan2(location.x, location.y)
        #else
        let arctan = atan2(location.x, -location.y)
        #endif
        let positiveRadians = arctan >= 0 ? arctan : arctan + 2 * .pi
        return Angle(radians: Double(positiveRadians))
    }

    private func setAngle(_ angle: Angle) {
        type.setAngle(angle, date: &date.wrappedValue, calendar: calendar)
    }
}

#if DEBUG
struct ArmDragGesture_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Preview()
            VStack {
                Spacer(minLength: 300)
                Preview()
                Spacer(minLength: 100)
            }
        }
    }

    private struct Preview: View {
        @Environment(\.calendar) var calendar
        @State private var date = Date.init(hour: 0, minute: 0, calendar: .current)
        let type = ArmType.minute

        var body: some View {
            VStack {
                ClassicArm(type: .minute)
                    .modifier(ArmDragGesture(type: ArmType.minute))
                    .rotationEffect(rotationAngle)
                    .background(Color.red.opacity(10/100))
                Text("minute: \(calendar.component(.minute, from: date))")
            }.environment(\.clockDate, $date)
        }

        private var rotationAngle: Angle {
            type.angle(date: date, calendar: calendar)
        }
    }
}
#endif
