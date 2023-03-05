import SwiftUI

struct WindUpKey: Shape, Animatable {
    var animationStep: Double

    var animatableData: Double {
        get { animationStep }
        set { animationStep = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        addOutline(to: &path, rect: rect)
        addCircles(to: &path, rect: rect)
        return path.applying(CGAffineTransform(
            a: 1 - animationStep * 2, b: 0,
            c: 0, d: 1,
            tx: animationStep * 2 * rect.midX, ty: 0
        ))
    }

    private func addOutline(to path: inout Path, rect: CGRect) {
        let thickness = rect.radius * 1/6
        let holeRadius = rect.radius * 1/3
        let holeCenterY = holeRadius/2 + rect.radius/2 + thickness
        let leftHole = CGRect.circle(center: CGPoint(x: rect.radius * 1/2, y: holeCenterY), radius: holeRadius)
        let rightHole = CGRect.circle(center: CGPoint(x: rect.radius * 3/2, y: holeCenterY), radius: holeRadius)
        let topHole = CGRect.circle(center: CGPoint(x: rect.radius, y: holeRadius/2 + thickness), radius: holeRadius/2)

        path.move(to: CGPoint(x: rect.width * 1/3, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.width * 1/3, y: leftHole.maxY + thickness))
        path.addArc(
            center: leftHole.center,
            radius: leftHole.radius + thickness,
            startAngle: .radians(.pi/2),
            endAngle: .radians(.pi * 3/2),
            clockwise: false
        )
        path.addArc(
            center: topHole.center,
            radius: topHole.radius + thickness,
            startAngle: .radians(.pi),
            endAngle: .zero,
            clockwise: false
        )
        path.addArc(
            center: rightHole.center,
            radius: rightHole.radius + thickness,
            startAngle: .radians(.pi * 3/2),
            endAngle: .radians(.pi/2),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: rect.width * 2/3, y: rightHole.maxY + thickness))
        path.addLine(to: CGPoint(x: rect.width * 2/3, y: rect.maxY))
        path.closeSubpath()
    }

    private func addCircles(to path: inout Path, rect: CGRect) {
        let thickness = rect.radius * 1/6
        let holeRadius = rect.radius * 1/3
        let holeCenterY = holeRadius/2 + rect.radius/2 + thickness
        let leftHole = CGRect.circle(center: CGPoint(x: rect.radius * 1/2, y: holeCenterY), radius: holeRadius)
        let rightHole = CGRect.circle(center: CGPoint(x: rect.radius * 3/2, y: holeCenterY), radius: holeRadius)
        let topHole = CGRect.circle(center: CGPoint(x: rect.radius, y: holeRadius/2 + thickness), radius: holeRadius/2)

        path.addCircle(leftHole)
        path.addCircle(rightHole)
        path.addCircle(topHole)
    }
}

#if DEBUG
struct WindUpKey_Previews: PreviewProvider {
    static var previews: some View {
        WindUpKey(animationStep: .zero)
            .stroke()
            .padding(1)
    }
}

struct WindUpKeyWithSteps_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    private struct Preview: View {
        @State private var animationStep: Double = 0

        var body: some View {
            VStack {
                WindUpKey(animationStep: animationStep).stroke()

                Text(String(format: "%.f", animationStep * 100))

                Slider(value: $animationStep, in: 0...1)
            }
            .padding()
        }
    }
}
#endif
