import SwiftUI

struct SteampunkMinuteArm: Shape {
    static let lineWidthRatio: CGFloat = 1/40

    func path(in rect: CGRect) -> Path {
        var path = Path()
        addBottomCircle(to: &path, rect: rect)
        addDroplet(to: &path, rect: rect)
        addBottomRectange(to: &path, rect: rect)
        addSun(to: &path, rect: rect)
        addTopRectange(to: &path, rect: rect)
        addArrow(to: &path, rect: rect)
        path.addVerticalMirror(in: rect)

        path.addCircle(CGRect.circle(center: rect.center, radius: rect.radius * 1/15))
        addDropletHole(to: &path, rect: rect)
        addSunHole(to: &path, rect: rect)
        return path
    }

    private func addBottomCircle(to path: inout Path, rect: CGRect) {
        let circle = CGRect.circle(center: rect.center, radius: rect.radius * 1/15)
        let lineWidth = rect.radius * Self.lineWidthRatio

        let bottom = CGPoint(x: rect.midX, y: circle.maxY + lineWidth)
        let topRight = CGPoint(x: rect.midX + lineWidth/2, y: circle.minY - lineWidth)

        path.move(to: bottom)
        path.addArc(
            center: rect.center,
            radius: circle.radius + lineWidth,
            startAngle: .inCircle(for: bottom, circleCenter: rect.center),
            endAngle: .inCircle(for: topRight, circleCenter: rect.center),
            clockwise: true
        )
    }

    private func addDroplet(to path: inout Path, rect: CGRect) {
        let center = CGPoint(x: rect.midX, y: rect.midY - rect.radius * 1/4)
        let radius = rect.radius * 1/30

        let lineWidth = rect.radius * Self.lineWidthRatio
        let outlineBottomRightPoint = CGPoint(x: center.x + lineWidth/2, y: center.y + radius + lineWidth)
        let topY = center.y - radius * 2 - lineWidth

        path.addArc(center: center, radius: radius + lineWidth, startAngle: .inCircle(for: outlineBottomRightPoint, circleCenter: center), endAngle: .zero, clockwise: true)

        let outlineTopRightPoint = CGPoint(x: rect.midX + lineWidth/2, y: topY)
        path.addLine(to: outlineTopRightPoint)
    }

    private func addDropletHole(to path: inout Path, rect: CGRect) {
        let center = CGPoint(x: rect.midX, y: rect.midY - rect.radius * 1/4)
        let radius = rect.radius * 1/30
        let circle = CGRect.circle(center: center, radius: radius)

        path.move(to: CGPoint(x: circle.maxX, y: center.y))
        path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: .fullRound/2, clockwise: false)
        path.addLine(to: CGPoint(x: center.x, y: center.y - radius * 2))
        path.addLine(to: CGPoint(x: circle.maxX, y: center.y))
    }

    private func addBottomRectange(to path: inout Path, rect: CGRect) {
        let lineWidth = rect.radius * Self.lineWidthRatio
        let center = CGPoint(x: rect.midX, y: rect.midY - rect.radius * 3/8)
        addRectangle(to: &path, center: center, lineWidth: lineWidth)
    }

    private func addTopRectange(to path: inout Path, rect: CGRect) {
        let lineWidth = rect.radius * Self.lineWidthRatio
        let center = CGPoint(x: rect.midX, y: rect.midY - rect.radius * 5/8)
        addRectangle(to: &path, center: center, lineWidth: lineWidth)
    }

    private func addRectangle(to path: inout Path, center: CGPoint, lineWidth: CGFloat) {
        let bottomRight = CGPoint(x: center.x + lineWidth/2, y: center.y + lineWidth/2)
        let topRight = CGPoint(x: center.x + lineWidth/2, y: center.y - lineWidth/2)
        path.addLine(to: bottomRight)
        path.addLine(to: CGPoint(x: center.x + lineWidth * 2, y: center.y + lineWidth/2))
        path.addLine(to: CGPoint(x: center.x + lineWidth * 2, y: center.y - lineWidth/2))
        path.addLine(to: topRight)
    }

    private func addArrow(to path: inout Path, rect: CGRect) {
        let lineWidth = rect.radius * Self.lineWidthRatio
        let center = CGPoint(x: rect.midX, y: rect.midY - rect.radius * 7/10)
        let top = CGPoint(x: rect.midX, y: rect.midY - rect.radius * 6/7)

        let bottomRight = CGPoint(x: center.x + lineWidth/2, y: center.y + lineWidth)

        path.addLine(to: bottomRight)
        path.addLine(to: CGPoint(x: center.x + lineWidth/2, y: center.y + lineWidth))
        path.addLine(to: CGPoint(x: center.x + lineWidth * 2, y: center.y))
        path.addLine(to: CGPoint(x: top.x, y: top.y))
    }

    private func addSun(to path: inout Path, rect: CGRect) {
        let lineWidth = rect.radius * Self.lineWidthRatio
        let center = CGPoint(x: rect.midX, y: rect.midY - rect.radius * 1/2)
        let insideCircle = CGRect.circle(center: center, radius: rect.radius * 1/30)
        let outlineCircle = CGRect.circle(center: center, radius: insideCircle.radius * 2)

        let bottomRight = CGPoint(x: rect.midX + lineWidth/2, y: outlineCircle.maxY)

        path.addLine(to: bottomRight)

        let beamCount = 12
        let degreeByBeam = 360/Double(beamCount)
        for beam in 1...beamCount/2 {
            let point: CGPoint
            if beam == beamCount/2 {
                point = CGPoint(x: rect.midX + lineWidth/2, y: outlineCircle.minY)
            } else {
                point = CGPoint.inCircle(outlineCircle, for: Angle(degrees: Double(beamCount/2 - beam) * degreeByBeam))
            }

            let control = CGPoint.inCircle(insideCircle, for: Angle(degrees: Double(beamCount/2 - beam) * degreeByBeam + degreeByBeam/2))
            path.addQuadCurve(to: point, control: control)
        }
    }

    private func addSunHole(to path: inout Path, rect: CGRect) {
        let center = CGPoint(x: rect.midX, y: rect.midY - rect.radius * 1/2)
        path.addCircle(CGRect.circle(center: center, radius: rect.radius * 1/30))
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
