import SwiftUI

struct SteampunkHourArm: Shape {
    func path(in rect: CGRect) -> Path {
        let thickness = rect.radius * 1/30
        let middleHoleCenter = CGPoint(x: rect.midX, y: rect.midY - rect.radius * 1/4 - thickness)

        var path = Path()
        addBottomHole(to: &path, rect: rect)
        addMiddleHole(to: &path, rect: rect)
        addRectangle(to: &path, rect: rect)
        addArrow(to: &path, rect: rect)
        addVerticalMirror(to: &path, rect: rect)

        path.addCircle(CGRect.circle(center: rect.center, radius: rect.radius * 1/15))
        path.addCircle(CGRect.circle(center: middleHoleCenter, radius: rect.radius * 1/30))

        return path
    }

    private func addBottomHole(to path: inout Path, rect: CGRect) {
        let thickness = rect.radius * 1/30
        let endPoint = CGPoint(x: rect.midX + thickness/2, y: rect.midY - rect.radius * 1/15 - thickness)
        path.addArc(
            center: rect.center,
            radius: rect.radius * 1/15 + thickness,
            startAngle: .fullRound * 1/4,
            endAngle: .inCircle(for: endPoint, circleCenter: rect.center),
            clockwise: true
        )
    }

    private func addMiddleHole(to path: inout Path, rect: CGRect) {
        let thickness = rect.radius * 1/30
        let circle = CGRect.circle(
            center: CGPoint(x: rect.midX, y: rect.midY - rect.radius * 1/4 - thickness),
            radius: rect.radius * 1/30 + thickness
        )
        let startPoint = CGPoint(x: rect.midX + thickness/2, y: circle.maxY)
        let endPoint = CGPoint(x: rect.midX + thickness/2, y: circle.minY)
        path.addArc(
            center: circle.center,
            radius: circle.radius,
            startAngle: .inCircle(for: startPoint, circleCenter: circle.center),
            endAngle: .inCircle(for: endPoint, circleCenter: circle.center),
            clockwise: true
        )
    }

    func addRectangle(to path: inout Path, rect: CGRect) {
        let thickness = rect.radius * 1/30
        let y = rect.midY - rect.radius * 4/9

        path.addLine(to: CGPoint(x: rect.midX + thickness/2, y: y))
        path.addLine(to: CGPoint(x: rect.midX + thickness * 2, y: y))
        path.addLine(to: CGPoint(x: rect.midX + thickness * 2, y: y - thickness))
        path.addLine(to: CGPoint(x: rect.midX + thickness/2, y: y - thickness))
    }

    func addArrow(to path: inout Path, rect: CGRect) {
        let thickness = rect.radius * 1/30
        let bottomY = rect.midY - rect.radius * 49/90
        let middleY = rect.midY - rect.radius * 41/72
        let topY = rect.midY - rect.radius * 25/36
        path.addLine(to: CGPoint(x: rect.midX + thickness/2, y: bottomY))
        path.addLine(to: CGPoint(x: rect.midX + thickness * 2, y: middleY))
        path.addLine(to: CGPoint(x: rect.midX, y: topY))
    }

    // TODO: refactor that, add directly to an extension of Path
    private func addVerticalMirror(to path: inout Path, rect: CGRect) {
        let mirror = path
            .applying(.init(scaleX: -1, y: 1))
            .applying(.init(translationX: rect.width, y: 0))
        #if os(iOS)
        let reversedPath = Path(UIBezierPath(cgPath: mirror.cgPath).reversing().cgPath)
        #else
        let reversedPath = Path(NSBezierPath(cgPath: mirror.cgPath).reversed.cgPath)
        #endif

        reversedPath.forEach {
            switch $0 {
            case .move: break
            case .closeSubpath: break
            case .line(to: let to):
                path.addLine(to: to)
            case .quadCurve(to: let to, control: let control):
                path.addQuadCurve(to: to, control: control)
            case .curve(to: let to, control1: let control1, control2: let control2):
                path.addCurve(to: to, control1: control1, control2: control2)
            }
        }

        path.closeSubpath()
    }
}

struct SteampunkHourArm_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            SteampunkHourArm().fill(style: .init(eoFill: true, antialiased: true))
        }
        .padding()
    }
}
