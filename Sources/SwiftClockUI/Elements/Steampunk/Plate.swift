import SwiftUI

struct Plate: View {
    static let lineWidth: CGFloat = 6
    let type: PlateType
    let text: String
    @State private var rect: CGRect = .zero

    var body: some View {
        ZStack {
            if type == .hard {
                Circle().fill(Color.background)
                Circle().stroke(lineWidth: Self.lineWidth)
            } else {
                Circle()
                    .scale(10/12)
                    .fill(Color.background)
            }
            Circle()
                .stroke(lineWidth: Self.lineWidth)
                .scale(10/12)
            rivets
            Text(text)
                .font(.system(size: rect.radius.rounded(), design: .serif))
        }
        .background(GeometryReader { geometry in
            Color.clear.preference(key: RectPreferenceKey.self, value: geometry.circle)
        })
        .onPreferenceChange(RectPreferenceKey.self) { rect = $0 }
    }

    private var rivets: some View {
        Group {
            if self.type == .soft {
                SoftRivets()
            } else {
                HardRivets()
            }
        }
    }
}

extension Plate {
    enum PlateType {
        case hard, soft
    }
}

private struct SoftRivets: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = rect.radius * 1/20

        let center1 = CGPoint.inCircle(
            rect,
            for: .radians(7/4 * .pi),
            margin: rect.radius * 40/100
        )
        let center2 = CGPoint.inCircle(
            rect,
            for: .radians(3/4 * .pi),
            margin: rect.radius * 40/100
        )
        path.addCircle(CGRect.circle(center: center1, radius: radius))
        path.addCircle(CGRect.circle(center: center2, radius: radius))

        return path
    }
}

private struct HardRivets: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = rect.radius * 1/20
        for rivet in 0..<20 {
            let rivet = CGFloat(rivet)
            let center = CGPoint.inCircle(
                rect,
                for: .radians(.pi/10 * rivet),
                margin: rect.radius * 1/12
            )
            let circleRect = CGRect.circle(center: center, radius: radius)
            path.addCircle(circleRect)
        }
        return path
    }
}

private struct RectPreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}

#if DEBUG
struct PlateSoftI_Previews: PreviewProvider {
    static var previews: some View {
        Plate(type: .soft, text: "I")
            .padding(1)
    }
}

struct PlateHardXII_Previews: PreviewProvider {
    static var previews: some View {
        Plate(type: .hard, text: "XII")
            .padding(4)
    }
}
#endif
