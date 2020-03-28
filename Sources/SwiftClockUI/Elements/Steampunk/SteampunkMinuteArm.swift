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
        let bottomArrowY = center.y - width * 3/10
        let arrowWidth = width * 1/4

        var path = Path()
        startCircle(path: &path, center: center, radius: startRadius, thickness: thickness)
        rightPart(path: &path, center: dropletCenter, radius: dropletRadius, bottomY: holeBottomY, thickness: thickness)
        arrow(path: &path, bottomY: bottomArrowY, width: arrowWidth, center: center, thickness: thickness)
        leftPart(path: &path, center: dropletCenter, radius: dropletRadius, bottomY: holeBottomY, thickness: thickness, bottomArrowY: bottomArrowY)
        path.closeSubpath()
        droplet(path: &path, center: dropletCenter, radius: dropletRadius)
        addSun(to: &path, rect: rect, thickness: thickness)
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
    private func rightPart(path: inout Path, center: CGPoint, radius: CGFloat, bottomY: CGFloat, thickness: CGFloat) {
        let holeBottomRight = CGPoint(x: center.x + thickness/2, y: bottomY + thickness)

        path.addLine(to: holeBottomRight)

        path.addArc(center: center, radius: radius + thickness, startAngle: .inCircle(for: holeBottomRight, circleCenter: center), endAngle: .zero, clockwise: true)

        let topY = bottomY - radius - thickness * 4
        path.addLine(to: CGPoint(x: center.x + thickness/2, y: topY))
        addRightBottomRectangle(to: &path, center: center, radius: radius, thickness: thickness, topY: topY)
        path.addLine(to: CGPoint(x: center.x + thickness/2, y: topY))
    }

    private func addRightBottomRectangle(to path: inout Path, center: CGPoint, radius: CGFloat, thickness: CGFloat, topY: CGFloat) {
        path.addLine(to: CGPoint(x: center.x + thickness/2, y: topY - thickness))
        path.addLine(to: CGPoint(x: center.x + thickness * 2, y: topY - thickness))
        path.addLine(to: CGPoint(x: center.x + thickness * 2, y: topY - thickness * 2))
        path.addLine(to: CGPoint(x: center.x + thickness/2, y: topY - thickness * 2))
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
    private func leftPart(path: inout Path, center: CGPoint, radius: CGFloat, bottomY: CGFloat, thickness: CGFloat, bottomArrowY: CGFloat) {
        path.addLine(to: CGPoint(x: center.x - thickness/2, y: path.currentPoint?.y ?? 0))

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

    private func addSun(to path: inout Path, rect: CGRect, thickness: CGFloat) {
        let center = CGPoint(x: rect.midX, y: rect.midY - rect.radius * 1/2)
        let insideCircle = CGRect.circle(center: center, radius: rect.radius * 1/30)
        let outlineCircle = CGRect.circle(center: center, radius: insideCircle.radius * 2)
        path.move(to: CGPoint(x: outlineCircle.midX, y: outlineCircle.minY))
        path.move(to: CGPoint(x: rect.midX + thickness/2, y: outlineCircle.minY))

        let beamCount = 12
        let degreeByBeam = 360/Double(beamCount)
        for beam in 1...beamCount {
            let point: CGPoint
            if beam == beamCount/2 {
                point = CGPoint(x: rect.midX + thickness/2, y: outlineCircle.maxY)
            } else if (beam == beamCount) {
                point = CGPoint(x: rect.midX - thickness/2, y: outlineCircle.minY)
            } else {
                point = CGPoint.inCircle(outlineCircle, for: Angle(degrees: Double(beam) * degreeByBeam))
            }

            let control = CGPoint.inCircle(insideCircle, for: Angle(degrees: Double(beam) * degreeByBeam - degreeByBeam/2))
            path.addQuadCurve(to: point, control: control)

            if beam == beamCount/2 {
                path.move(to: CGPoint(x: rect.midX - thickness/2, y: outlineCircle.maxY))
            }
        }
        path.addCircle(insideCircle)
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
