import SwiftUI

struct WindUpKey: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        outline(path: &path, rect: rect)
        holes(path: &path, rect: rect)
        return path
    }

    private func outline(path: inout Path, rect: CGRect) {
        let (width, thickness, holeRadius, holeCenterY, leftHoleCenter, rightHoleCenter, upperHoleCenter) = dimensions(rect: rect)

        path.move(to: CGPoint(x: width * 1/3, y: rect.maxY))

        path.addLine(to: CGPoint(x: width * 1/3, y: holeCenterY + holeRadius + thickness))

        path.addArc(center: leftHoleCenter, radius: holeRadius + thickness, startAngle: .radians(.pi/2), endAngle: .radians(.pi * 3/2), clockwise: false)

        path.addArc(center: upperHoleCenter, radius: holeRadius/2 + thickness, startAngle: .radians(.pi), endAngle: .zero, clockwise: false)

        path.addArc(center: rightHoleCenter, radius: holeRadius + thickness, startAngle: .radians(.pi * 3/2), endAngle: .radians(.pi/2), clockwise: false)

        path.addLine(to: CGPoint(x: width * 2/3, y: holeCenterY + holeRadius + thickness))

        path.addLine(to: CGPoint(x: width * 2/3, y: rect.maxY))

        path.closeSubpath()
    }

    private func holes(path: inout Path, rect: CGRect) {
        let (_, _, holeRadius, holeCenterY, leftHoleCenter, rightHoleCenter, upperHoleCenter) = dimensions(rect: rect)

        path.move(to: CGPoint(x: leftHoleCenter.x + holeRadius, y: holeCenterY))

        path.addArc(center: leftHoleCenter, radius: holeRadius, startAngle: .zero, endAngle: .radians(2 * .pi), clockwise: false)

        path.move(to: CGPoint(x: rightHoleCenter.x + holeRadius, y: holeCenterY))

        path.addArc(center: rightHoleCenter, radius: holeRadius, startAngle: .zero, endAngle: .fullRound, clockwise: false)

        path.move(to: CGPoint(x: upperHoleCenter.x + holeRadius/2, y: upperHoleCenter.y))

        path.addArc(center: upperHoleCenter, radius: holeRadius/2, startAngle: .zero, endAngle: .fullRound, clockwise: false)
    }

    private typealias Dimensions = (
        width: CGFloat,
        thickness: CGFloat,
        holeRadius: CGFloat,
        holeCenterY: CGFloat,
        leftHoleCenter: CGPoint,
        rightHoleCenter: CGPoint,
        upperHoleCenter: CGPoint
    )
    private func dimensions(rect: CGRect) -> Dimensions {
        let width = min(rect.width, rect.height)
        let thickness = width * 1/12
        let holeRadius = width/6
        let holeCenterY = holeRadius/2 + width/4 + thickness
        let leftHoleCenter = CGPoint(x: width * 1/4, y: holeCenterY)
        let rightHoleCenter = CGPoint(x: width * 3/4, y: holeCenterY)
        let upperHoleCenter = CGPoint(x: width/2, y:  holeRadius/2 + thickness)
        return (width, thickness, holeRadius, holeCenterY, leftHoleCenter, rightHoleCenter, upperHoleCenter)
    }
}

struct WindUpKey_Previews: PreviewProvider {
    static var previews: some View {
        WindUpKey()
            .stroke()
            .padding()
    }
}
