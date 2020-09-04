import SwiftUI

struct Plate: View {
    static let lineWidth: CGFloat = 6
    let type: PlateType
    let text: String

    var body: some View {
        GeometryReader(content: content)
    }

    private func content(geometry: GeometryProxy) -> some View {
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
                .font(.system(size: geometry.radius.rounded(), design: .serif))
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

struct Plate_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Plate(type: .soft, text: "I")
            Plate(type: .hard, text: "XII")
        }.padding()
    }
}
