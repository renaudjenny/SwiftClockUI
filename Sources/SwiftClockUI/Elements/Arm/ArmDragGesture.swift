import SwiftUI

struct ArmDragGesture: ViewModifier {
    @Binding var dragAngle: Angle
    @Binding var isDragging: Bool
    let setAngle: (Angle) -> Void

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content.gesture(self.dragGesture(geometry: geometry))
        }
    }

    private func dragGesture(geometry: GeometryProxy) -> some Gesture {
        DragGesture(coordinateSpace: .global)
            .onChanged({
                self.isDragging = true
                self.dragAngle = self.angle(dragGestureValue: $0, frame: geometry.frame(in: .global))
            })
            .onEnded({
                let angle = self.angle(dragGestureValue: $0, frame: geometry.frame(in: .global))
                self.setAngle(angle)
                self.isDragging = false
            })
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
        let positiveRadians = arctan > 0 ? arctan : arctan + 2 * .pi
        return Angle(radians: Double(positiveRadians))
    }
}
