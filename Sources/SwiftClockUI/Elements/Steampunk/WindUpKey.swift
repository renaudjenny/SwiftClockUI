import SwiftUI

struct WindUpKey: Shape {
    func path(in rect: CGRect) -> Path {
        let width = min(rect.width, rect.height)
        let thickness = width * 1/12
        let holeRadius = width/6
        let holeCenterY = holeRadius/2 + width/4 + thickness
        let leftHoleCenter = CGPoint(x: width * 1/4, y: holeCenterY)
        let rightHoleCenter = CGPoint(x: width * 3/4, y: holeCenterY)
        let upperHoleCenter = CGPoint(x: width/2, y:  holeRadius/2 + thickness)

        var path = Path()
        outline(path: &path, width: width, maxY: rect.maxY, thickness: thickness, holeRadius: holeRadius, holeCenterY: holeCenterY, leftHoleCenter: leftHoleCenter, rightHoleCenter: rightHoleCenter, upperHoleCenter: upperHoleCenter)
        holes(path: &path, holeRadius: holeRadius, holeCenterY: holeCenterY, leftHoleCenter: leftHoleCenter, rightHoleCenter: rightHoleCenter, upperHoleCenter: upperHoleCenter)
        return path
    }

    private func outline(path: inout Path, width: CGFloat, maxY: CGFloat, thickness: CGFloat, holeRadius: CGFloat, holeCenterY: CGFloat, leftHoleCenter: CGPoint, rightHoleCenter: CGPoint, upperHoleCenter: CGPoint) {
        path.move(to: CGPoint(x: width * 1/3, y: maxY))
        path.addLine(to: CGPoint(x: width * 1/3, y: holeCenterY + holeRadius + thickness))
        path.addArc(center: leftHoleCenter, radius: holeRadius + thickness, startAngle: .radians(.pi/2), endAngle: .radians(.pi * 3/2), clockwise: false)
        path.addArc(center: upperHoleCenter, radius: holeRadius/2 + thickness, startAngle: .radians(.pi), endAngle: .zero, clockwise: false)
        path.addArc(center: rightHoleCenter, radius: holeRadius + thickness, startAngle: .radians(.pi * 3/2), endAngle: .radians(.pi/2), clockwise: false)
        path.addLine(to: CGPoint(x: width * 2/3, y: holeCenterY + holeRadius + thickness))
        path.addLine(to: CGPoint(x: width * 2/3, y: maxY))
        path.closeSubpath()
    }

    private func holes(path: inout Path, holeRadius: CGFloat, holeCenterY: CGFloat, leftHoleCenter: CGPoint, rightHoleCenter: CGPoint, upperHoleCenter: CGPoint) {
        path.move(to: CGPoint(x: leftHoleCenter.x + holeRadius, y: holeCenterY))
        path.addArc(center: leftHoleCenter, radius: holeRadius, startAngle: .zero, endAngle: .radians(2 * .pi), clockwise: false)
        path.move(to: CGPoint(x: rightHoleCenter.x + holeRadius, y: holeCenterY))
        path.addArc(center: rightHoleCenter, radius: holeRadius, startAngle: .zero, endAngle: .fullRound, clockwise: false)
        path.move(to: CGPoint(x: upperHoleCenter.x + holeRadius/2, y: upperHoleCenter.y))
        path.addArc(center: upperHoleCenter, radius: holeRadius/2, startAngle: .zero, endAngle: .fullRound, clockwise: false)
    }
}

struct WindUpKey_Previews: PreviewProvider {
    static var previews: some View {
        WindUpKey()
            .stroke()
            .padding()
    }
}
