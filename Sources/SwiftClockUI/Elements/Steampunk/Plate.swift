import SwiftUI

struct Plate: View {
    static let lineWidth: CGFloat = 6
    let type: PlateType
    let text: String
    @State private var radius: CGFloat = .zero

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
                .font(.system(size: radius.rounded(), design: .serif))
        }
        .background(
            GeometryReader {
                Color.clear
                    .preference(key: RadiusPreferenceKey.self, value: $0.radius)
            }
        )
        .onPreferenceChange(RadiusPreferenceKey.self) {
            radius = $0
        }
    }

    private var rivets: some View {
        Group {
            if self.type == .soft {
                softRivets
            } else {
                hardRivets
            }
        }
    }

    private var softRivets: some View {
        ZStack {
            Circle()
                .scale(1/20)
                .modifier(PositionInCircle(angle: .degrees(-45), marginRatio: 2/5))
            Circle()
                .scale(1/20)
                .modifier(PositionInCircle(angle: .degrees(135), marginRatio: 2/5))
        }
    }

    private var hardRivets: some View {
        ForEach(0..<20) { rivet in
            Circle()
                .scale(1/20)
            .modifier(PositionInCircle(angle: .degrees(Double(rivet) * 360/20), marginRatio: 1/11))
        }
    }
}

extension Plate {
    enum PlateType {
        case hard, soft
    }
}

extension Plate {
    // TODO: this preference key looks very similar to NumberCircleRadiusPreferenceKey
    // I should create a more generic usage of this behaviour
    struct RadiusPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = .zero

        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = max(value, nextValue())
        }
    }
}

struct Plate_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Plate(type: .soft, text: "I")
            Plate(type: .hard, text: "XII")
        }.padding()
    }
}
