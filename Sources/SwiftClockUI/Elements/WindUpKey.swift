import SwiftUI

struct WindUpKey: Shape {
    func path(in rect: CGRect) -> Path {
        let width = min(rect.width, rect.height)
        let thickness = width * 1/20

        var path = Path()

        let holeCenterY = width/3 + thickness
        let holeRadius = width/5
        let leftHoleCenter = CGPoint(x: width * 1/4, y: holeCenterY)
        let rightHoldeCenter = CGPoint(x: width * 3/4, y: holeCenterY)
        let upperHolerCenter = CGPoint(x: width/2, y:  holeRadius/2 + thickness)

        // Outline

        path.move(to: CGPoint(x: width * 1/3, y: rect.maxY))

        path.addLine(to: CGPoint(x: width * 1/3, y: holeCenterY + holeRadius + thickness))

        path.addArc(center: leftHoleCenter, radius: holeRadius + thickness, startAngle: .radians(.pi/2), endAngle: .radians(.pi * 11/7), clockwise: false)

        path.addArc(center: upperHolerCenter, radius: holeRadius/2 + thickness, startAngle: .radians(.pi), endAngle: .zero, clockwise: false)

        path.addArc(center: rightHoldeCenter, radius: holeRadius + thickness, startAngle: .radians(.pi * 11/8), endAngle: .radians(.pi/2), clockwise: false)

        path.addLine(to: CGPoint(x: width * 2/3, y: holeCenterY + holeRadius + thickness))

        path.addLine(to: CGPoint(x: width * 2/3, y: rect.maxY))

        path.closeSubpath()

        // Holes

        path.move(to: CGPoint(x: leftHoleCenter.x + holeRadius, y: holeCenterY))

        path.addArc(center: leftHoleCenter, radius: holeRadius, startAngle: .zero, endAngle: .radians(2 * .pi), clockwise: false)

        path.move(to: CGPoint(x: rightHoldeCenter.x + holeRadius, y: holeCenterY))

        path.addArc(center: rightHoldeCenter, radius: holeRadius, startAngle: .zero, endAngle: .fullRound, clockwise: false)

        path.move(to: CGPoint(x: upperHolerCenter.x + holeRadius/2, y: upperHolerCenter.y))

        path.addArc(center: upperHolerCenter, radius: holeRadius/2, startAngle: .zero, endAngle: .fullRound, clockwise: false)

        return path
    }
}

struct WindUpKey_Previews: PreviewProvider {
    static var previews: some View {
        WindUpKey()
            .stroke()
            .padding()
    }
}
