import SwiftUI

struct ArmDragGesture: ViewModifier {
    @Environment(\.calendar) var calendar
    @Environment(\.clockDate) var date
    @GestureState private var dragAngle: Angle = .zero
    let type: ArmType

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content.gesture(self.dragGesture(geometry: geometry))
        }
        .rotationEffect(dragAngle)
        .animation(dragAngle == .zero ? .spring() : nil, value: dragAngle)
    }

    private func dragGesture(geometry: GeometryProxy) -> some Gesture {
        DragGesture(coordinateSpace: .global)
            .updating($dragAngle, body: { value, state, _ in
                let extraRotationAngle = self.angle(dragGestureValue: value, frame: geometry.frame(in: .global))
                state = extraRotationAngle - self.currentAngle
            })
            .onEnded({
                self.setAngle(self.angle(dragGestureValue: $0, frame: geometry.frame(in: .global)))
            })
    }

    private var currentAngle: Angle {
        type.angle(date: date.wrappedValue, calendar: calendar)
    }

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
                Spacer(minLength: 200)
                Preview()
                Spacer(minLength: 200)
            }
        }
    }

    private struct Preview: View {
        @Environment(\.calendar) var calendar
        @Environment(\.clockDate) var date
        let type = ArmType.minute

        var body: some View {
            ClassicArm(type: .minute)
                .modifier(ArmDragGesture(type: ArmType.minute))
                .rotationEffect(rotationAngle)
                .animation(.spring(), value: rotationAngle)
                .background(Color.red.opacity(10/100))
        }

        private var rotationAngle: Angle {
            type.angle(date: date.wrappedValue, calendar: calendar)
        }
    }
}
#endif
