import SwiftUI

struct SteampunkMinuteArm: Shape {
    func path(in rect: CGRect) -> Path {
        let width = min(rect.width, rect.height)
        let thickness = width * 1/80
        let startRadius = width * 1/30
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let holeBottomY = center.y - width * 1/10
        let dropletRadius = startRadius * 1/2
        let dropletCenter = CGPoint(x: center.x, y: holeBottomY - dropletRadius)
        let sunCenter = CGPoint(x: center.x, y: center.y - width * 1/4)
        let sunRadius = startRadius * 1/2
        let bottomArrowY = center.y - width * 3/10
        let arrowWidth = width * 1/4

        var path = Path()
        startCircle(path: &path, center: center, radius: startRadius, thickness: thickness)
        rightPart(path: &path, center: dropletCenter, radius: dropletRadius, bottomY: holeBottomY, thickness: thickness, sunCenter: sunCenter, sunRadius: sunRadius)
        arrow(path: &path, bottomY: bottomArrowY, width: arrowWidth, center: center, thickness: thickness)
        leftPart(path: &path, center: dropletCenter, radius: dropletRadius, bottomY: holeBottomY, thickness: thickness, bottomArrowY: bottomArrowY, sunCenter: sunCenter, sunRadius: sunRadius)
        path.closeSubpath()
        droplet(path: &path, center: dropletCenter, radius: dropletRadius)
        sunCenterCircle(path: &path, center: sunCenter, radius: sunRadius)
        return path
    }

    // TODO: improve conventions of private functions to set addSomething(to path: inout path, ...)

    private func startCircle(path: inout Path, center: CGPoint, radius: CGFloat, thickness: CGFloat) {
        path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: .fullRound, clockwise: false)

        let leftStartThickCirclePoint = CGPoint(x: center.x - thickness/2, y: center.y - radius - thickness)
        let rightEndThickCirclePoint = CGPoint(x: center.x + thickness/2, y: center.y - radius - thickness)

        path.move(to: leftStartThickCirclePoint)
        path.addArc(center: center, radius: radius + thickness, startAngle: .inCircle(for: leftStartThickCirclePoint, circleCenter: center), endAngle: .inCircle(for: rightEndThickCirclePoint, circleCenter: center), clockwise: true)
    }

    // TODO: refactor this (split into tinier parts)
    private func rightPart(path: inout Path, center: CGPoint, radius: CGFloat, bottomY: CGFloat, thickness: CGFloat, sunCenter: CGPoint, sunRadius: CGFloat) {
        let holeBottomRight = CGPoint(x: center.x + thickness/2, y: bottomY + thickness)

        path.addLine(to: holeBottomRight)

        path.addArc(center: center, radius: radius + thickness, startAngle: .inCircle(for: holeBottomRight, circleCenter: center), endAngle: .zero, clockwise: true)

        let topY = bottomY - radius - thickness * 4
        path.addLine(to: CGPoint(x: center.x + thickness/2, y: topY))
        addRightBottomRectangle(to: &path, center: center, radius: radius, thickness: thickness, topY: topY)
        path.addLine(to: CGPoint(x: center.x + thickness/2, y: sunCenter.y + sunRadius + thickness))

        addRightSun(to: &path, center: sunCenter, radius: sunRadius, thickness: thickness)
    }

    private func addRightBottomRectangle(to path: inout Path, center: CGPoint, radius: CGFloat, thickness: CGFloat, topY: CGFloat) {
        path.addLine(to: CGPoint(x: center.x + thickness/2, y: topY - thickness))
        path.addLine(to: CGPoint(x: center.x + thickness * 2, y: topY - thickness))
        path.addLine(to: CGPoint(x: center.x + thickness * 2, y: topY - thickness * 2))
        path.addLine(to: CGPoint(x: center.x + thickness/2, y: topY - thickness * 2))
    }

    private func addRightSun(to path: inout Path, center: CGPoint, radius: CGFloat, thickness: CGFloat) {
        for arc in 1...4 {
            let point = CGPoint
                .pointInCircle(from: Angle(degrees: -Double(arc) * 35 + 180), diameter: radius, margin: -radius - thickness)
                .recenteredCircle(center: center, diameter: radius)

            let control = CGPoint
                .pointInCircle(from: Angle(degrees: -Double(arc) * 35 + 35/2 + 180), diameter: radius, margin: -radius * 1/2)
                .recenteredCircle(center: center, diameter: radius)

            path.addQuadCurve(to: point, control: control)
        }
        let control = CGPoint
            .pointInCircle(from: Angle(degrees: 35/2 + 180), diameter: radius, margin: radius + thickness/2)
            .recenteredCircle(center: center, diameter: radius)
        path.addQuadCurve(to: CGPoint(x: center.x + thickness/2, y: center.y - radius - thickness), control: control)
    }

    private func arrow(path: inout Path, bottomY: CGFloat, width: CGFloat, center: CGPoint, thickness: CGFloat) {
        path.addLine(to: CGPoint(x: center.x + thickness/2, y: bottomY))
        path.addLine(to: CGPoint(x: center.x + thickness * 2, y: bottomY))
        path.addLine(to: CGPoint(x: center.x + thickness * 2, y: bottomY - thickness))
        path.addLine(to: CGPoint(x: center.x + thickness/2, y: bottomY - thickness))
        path.addLine(to: CGPoint(x: center.x + thickness/2, y: bottomY - width * 1/7))
        path.addLine(to: CGPoint(x: center.x + thickness * 2, y: bottomY - width * 1/5))

        path.addLine(to: CGPoint(x: center.x, y: bottomY - width * 1/2))

        path.addLine(to: CGPoint(x: center.x - thickness * 2, y: bottomY - width * 1/5))
        path.addLine(to: CGPoint(x: center.x - thickness/2, y: bottomY - width * 1/7))
        path.addLine(to: CGPoint(x: center.x - thickness/2, y: bottomY - thickness))
        path.addLine(to: CGPoint(x: center.x - thickness * 2, y: bottomY - thickness))
        path.addLine(to: CGPoint(x: center.x - thickness * 2, y: bottomY))
        path.addLine(to: CGPoint(x: center.x - thickness/2, y: bottomY))
    }

    // TODO: refactor this (split into tinier parts)
    private func leftPart(path: inout Path, center: CGPoint, radius: CGFloat, bottomY: CGFloat, thickness: CGFloat, bottomArrowY: CGFloat, sunCenter: CGPoint, sunRadius: CGFloat) {
        path.addLine(to: CGPoint(x: center.x - thickness/2, y: sunCenter.y - sunRadius - thickness))

        for arc in 1...4 {
            let point = CGPoint
                .pointInCircle(from: Angle(degrees: -Double(arc) * 35), diameter: sunRadius, margin: -sunRadius - thickness)
                .recenteredCircle(center: sunCenter, diameter: radius)

            let control = CGPoint
                .pointInCircle(from: Angle(degrees: -Double(arc) * 35 + 35/2), diameter: sunRadius, margin: -sunRadius * 1/2)
                .recenteredCircle(center: sunCenter, diameter: radius)

            path.addQuadCurve(to: point, control: control)
        }
        let control = CGPoint
            .pointInCircle(from: Angle(degrees: 30/2 + 180), diameter: sunRadius, margin: sunRadius - thickness * 2)
            .recenteredCircle(center: sunCenter, diameter: radius)

        path.addQuadCurve(to: CGPoint(x: center.x - thickness/2, y: sunCenter.y + sunRadius + thickness), control: control)

        let topY = bottomY - radius - thickness * 4
        path.addLine(to: CGPoint(x: center.x - thickness/2, y: topY - thickness * 2))
        path.addLine(to: CGPoint(x: center.x - thickness * 2, y: topY - thickness * 2))
        path.addLine(to: CGPoint(x: center.x - thickness * 2, y: topY - thickness))
        path.addLine(to: CGPoint(x: center.x - thickness/2, y: topY - thickness))
        path.addLine(to: CGPoint(x: center.x - thickness/2, y: topY))

        let bottomLeft = CGPoint(x: center.x - thickness/2, y: bottomY + thickness)
        path.addArc(center: center, radius: radius + thickness, startAngle: .fullRound/2, endAngle: .inCircle(for: bottomLeft, circleCenter: center), clockwise: true)
    }

    private func droplet(path: inout Path, center: CGPoint, radius: CGFloat) {
        path.move(to: CGPoint(x: center.x + radius, y: center.y))
        path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: .fullRound/2, clockwise: false)
        path.addLine(to: CGPoint(x: center.x, y: center.y - radius * 2))
        path.addLine(to: CGPoint(x: center.x + radius, y: center.y))
    }

    private func sunCenterCircle(path: inout Path, center: CGPoint, radius: CGFloat) {
        path.move(to: CGPoint(x: center.x + radius, y: center.y))
        path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: .fullRound, clockwise: false)
    }
}

// TODO: move this to an extension
// TODO: add unit test (snapshot) for that
extension Path {
    mutating func addTest(to center: CGPoint) {
        let previous = currentPoint ?? .zero
        move(to: CGPoint(x: center.x + 2, y: center.y))
        addArc(center: center, radius: 2, startAngle: .zero, endAngle: .fullRound, clockwise: false)
        move(to: previous)
    }
}

struct SteampunkMinuteArm_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            SteampunkMinuteArm().fill(style: .init(eoFill: true, antialiased: true))
        }
        .padding()
    }
}
