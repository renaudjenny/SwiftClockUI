#if os(macOS)
import AppKit

extension NSBezierPath {
    // Inspired from https://stackoverflow.com/questions/1815568/how-can-i-convert-nsbezierpath-to-cgpath
    var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)

        for i in 0 ..< self.elementCount {
            let type = self.element(at: i, associatedPoints: &points)
            switch type {
            case .moveTo: path.move(to: points[0])
            case .lineTo: path.addLine(to: points[0])
            case .curveTo: path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePath: path.closeSubpath()
            @unknown default: break
            }
        }

        return path
    }

    // Inspired from https://gist.github.com/lukaskubanek/1f3585314903dfc66fc7
    convenience init(cgPath: CGPath) {
        self.init()
        cgPath.applyWithBlock {
            switch $0.pointee.type {
            case .moveToPoint:
                self.move(to: $0.pointee.points[0])
            case .addLineToPoint:
                self.line(to: $0.pointee.points[0])
            case .addQuadCurveToPoint:
                let firstPoint = $0.pointee.points[0]
                let secondPoint = $0.pointee.points[1]

                let currentPoint = self.currentPoint
                let x = (currentPoint.x + 2 * firstPoint.x) / 3
                let y = (currentPoint.y + 2 * firstPoint.y) / 3
                let interpolatedPoint = CGPoint(x: x, y: y)

                let endPoint = secondPoint

                self.curve(to: endPoint, controlPoint1: interpolatedPoint, controlPoint2: interpolatedPoint)
            case .addCurveToPoint:
                let to = $0.pointee.points[2]
                let controlPoint1 = $0.pointee.points[0]
                let controlPoint2 = $0.pointee.points[1]
                self.curve(to: to, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            case .closeSubpath:
                self.close()
            @unknown default: break
            }
        }
    }
}
#endif
