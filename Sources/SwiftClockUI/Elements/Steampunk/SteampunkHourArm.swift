import SwiftUI

struct SteampunkHourArm: Shape {
    func path(in rect: CGRect) -> Path {
        let width = min(rect.width, rect.height)
        let thickness = width * 1/60
        let startRadius = width * 1/30
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let holeBottomY = center.y - width * 1/8
        let holeRadius = startRadius * 1/2
        let holeCenter = CGPoint(x: center.x, y: holeBottomY - holeRadius)
        let bottomArrowY = center.y - width * 2/9
        let arrowWidth = width * 1/4

        var path = Path()
        startCircle(path: &path, center: center, radius: startRadius, thickness: thickness)
        rightPart(path: &path, center: holeCenter, radius: holeRadius, bottomY: holeBottomY, thickness: thickness, bottomArrowY: bottomArrowY)
        arrow(path: &path, bottomY: bottomArrowY, width: arrowWidth, center: center, thickness: thickness)
        leftPart(path: &path, center: holeCenter, radius: holeRadius, bottomY: holeBottomY, thickness: thickness, bottomArrowY: bottomArrowY)
        path.closeSubpath()
        circleHole(path: &path, holeCenter: holeCenter, holeRadius: holeRadius)
        return path
    }

    private func startCircle(path: inout Path, center: CGPoint, radius: CGFloat, thickness: CGFloat) {
        path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: .fullRound, clockwise: false)

        let leftStartThickCirclePoint = CGPoint(x: center.x - thickness/2, y: center.y - radius - thickness)
        let rightEndThickCirclePoint = CGPoint(x: center.x + thickness/2, y: center.y - radius - thickness)

        path.move(to: leftStartThickCirclePoint)
        path.addArc(center: center, radius: radius + thickness, startAngle: .inCircle(for: leftStartThickCirclePoint, circleCenter: center), endAngle: .inCircle(for: rightEndThickCirclePoint, circleCenter: center), clockwise: true)
    }

    private func rightPart(path: inout Path, center: CGPoint, radius: CGFloat, bottomY: CGFloat, thickness: CGFloat, bottomArrowY: CGFloat) {
        let holeBottomRight = CGPoint(x: center.x + thickness/2, y: bottomY + thickness)
        let holeTopRight = CGPoint(x: holeBottomRight.x, y: bottomY - radius - thickness * 2)

        path.addLine(to: holeBottomRight)

        path.addArc(center: center, radius: radius + thickness, startAngle: .inCircle(for: holeBottomRight, circleCenter: center), endAngle: .inCircle(for: holeTopRight, circleCenter: center), clockwise: true)

        path.addLine(to: CGPoint(x: center.x + thickness/2, y: bottomArrowY))
    }

    private func arrow(path: inout Path, bottomY: CGFloat, width: CGFloat, center: CGPoint, thickness: CGFloat) {
        path.addLine(to: CGPoint(x: center.x + thickness * 2, y: bottomY))
        path.addLine(to: CGPoint(x: center.x + thickness * 2, y: bottomY - thickness))
        path.addLine(to: CGPoint(x: center.x + thickness/2, y: bottomY - thickness))
        path.addLine(to: CGPoint(x: center.x + thickness/2, y: bottomY - width * 1/5))
        path.addLine(to: CGPoint(x: center.x + thickness * 2, y: bottomY - width * 1/4))

        path.addLine(to: CGPoint(x: center.x, y: bottomY - width * 1/2))

        path.addLine(to: CGPoint(x: center.x - thickness * 2, y: bottomY - width * 1/4))
        path.addLine(to: CGPoint(x: center.x - thickness/2, y: bottomY - width * 1/5))
        path.addLine(to: CGPoint(x: center.x - thickness/2, y: bottomY - thickness))
        path.addLine(to: CGPoint(x: center.x - thickness * 2, y: bottomY - thickness))
        path.addLine(to: CGPoint(x: center.x - thickness * 2, y: bottomY))
        path.addLine(to: CGPoint(x: center.x - thickness/2, y: bottomY))
    }

    private func leftPart(path: inout Path, center: CGPoint, radius: CGFloat, bottomY: CGFloat, thickness: CGFloat, bottomArrowY: CGFloat) {
        let holeTopLeft = CGPoint(x: center.x - thickness/2, y: bottomY - radius - thickness * 2)
        path.addLine(to: holeTopLeft)

        let holeBottomLeft = CGPoint(x: center.x - thickness/2, y: bottomY + thickness)
        path.addArc(center: center, radius: radius + thickness, startAngle: .inCircle(for: holeTopLeft, circleCenter: center), endAngle: .inCircle(for: holeBottomLeft, circleCenter: center), clockwise: true)
    }

    private func circleHole(path: inout Path, holeCenter: CGPoint, holeRadius: CGFloat) {
        path.move(to: CGPoint(x: holeCenter.x + holeRadius, y: holeCenter.y))
        path.addArc(center: holeCenter, radius: holeRadius, startAngle: .zero, endAngle: .fullRound, clockwise: false)
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
