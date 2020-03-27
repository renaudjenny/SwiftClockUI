import SwiftUI

struct WindUpKey: Shape {
    func path(in rect: CGRect) -> Path {
        let width = min(rect.width, rect.height)
        let thickness = width * 1/12
        let holeRadius = width/6
        let holeCenterY = holeRadius/2 + width/4 + thickness
        let leftHole = CGRect.circle(center: CGPoint(x: width * 1/4, y: holeCenterY), radius: holeRadius)
        let rightHole = CGRect.circle(center: CGPoint(x: width * 3/4, y: holeCenterY), radius: holeRadius)
        let topHole = CGRect.circle(center: CGPoint(x: width/2, y: holeRadius/2 + thickness), radius: holeRadius/2)

        var path = Path()
        addOutline(to: &path, rect: rect, thickness: thickness, leftHole: leftHole, rightHole: rightHole, topHole: topHole)
        path.addCircle(leftHole)
        path.addCircle(rightHole)
        path.addCircle(topHole)
        return path
    }

    private func addOutline(to path: inout Path, rect: CGRect, thickness: CGFloat, leftHole: CGRect, rightHole: CGRect, topHole: CGRect) {
        path.move(to: CGPoint(x: rect.width * 1/3, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.width * 1/3, y: leftHole.maxY + thickness))
        path.addArc(center: leftHole.center, radius: leftHole.radius + thickness, startAngle: .radians(.pi/2), endAngle: .radians(.pi * 3/2), clockwise: false)
        path.addArc(center: topHole.center, radius: topHole.radius + thickness, startAngle: .radians(.pi), endAngle: .zero, clockwise: false)
        path.addArc(center: rightHole.center, radius: rightHole.radius + thickness, startAngle: .radians(.pi * 3/2), endAngle: .radians(.pi/2), clockwise: false)
        path.addLine(to: CGPoint(x: rect.width * 2/3, y: rightHole.maxY + thickness))
        path.addLine(to: CGPoint(x: rect.width * 2/3, y: rect.maxY))
        path.closeSubpath()
    }
}

// TODO: move this extension into its own file
extension CGRect {
    static func circle(center: CGPoint, radius: CGFloat) -> Self {
        .init(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
    }

    var center: CGPoint { .init(x: midX, y: midY) }
    var radius: CGFloat { min(width, height)/2 }
}

// TODO: move this extension into its own file
extension Path {
    mutating func addCircle(_ circle: CGRect) {
        move(to: CGPoint(x: circle.maxX, y: circle.center.y))
        addArc(center: circle.center, radius: circle.radius, startAngle: .zero, endAngle: .fullRound, clockwise: false)
    }
}

struct WindUpKey_Previews: PreviewProvider {
    static var previews: some View {
        WindUpKey()
            .stroke()
            .padding()
    }
}
