import SwiftUI

struct WindUpKey: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let holeCenterY = rect.height/3
        let holeRadius = rect.width/5
        let leftHoleCenter = CGPoint(x: rect.width * 1/4, y: holeCenterY)

        path.addArc(center: leftHoleCenter, radius: holeRadius, startAngle: .zero, endAngle: .radians(2 * .pi), clockwise: false)

        let rightCenter = CGPoint(x: rect.width * 3/4, y: holeCenterY)

        path.move(to: CGPoint(x: rightCenter.x + holeRadius, y: holeCenterY))

        path.addArc(center: rightCenter, radius: holeRadius, startAngle: .zero, endAngle: .fullRound, clockwise: false)

        return path
    }
}

struct WindUpKey_Previews: PreviewProvider {
    static var previews: some View {
        WindUpKey()
            .stroke()
            .aspectRatio(contentMode: .fit)
    }
}
