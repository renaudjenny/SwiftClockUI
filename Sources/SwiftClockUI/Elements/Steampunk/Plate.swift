import SwiftUI

struct Plate: View {
    let type: PlateType
    let text: String

    var body: some View {
        ZStack {
            Circle()
                .stroke()
                .scale(10/12)
            if type == .hard {
                Circle().stroke()
            }
            rivets.aspectRatio(contentMode: .fit)
            Text(text).modifier(FontProportional(ratio: 1/2, design: .serif))
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
        GeometryReader { geometry in
            Circle()
                .scale(1/20)
                .position(.pointInCircle(from: .degrees(-45), diameter: geometry.diameter, margin: geometry.diameter * 1/5))
            Circle()
                .scale(1/20)
                .position(.pointInCircle(from: .degrees(135), diameter: geometry.diameter, margin: geometry.diameter * 1/5))
        }
    }

    private var hardRivets: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<20) { rivet in
                    Circle()
                        .scale(1/20)
                        .position(.pointInCircle(from: .degrees(Double(rivet) * 360/20), diameter: geometry.diameter, margin: geometry.diameter * 1/22))
                }
            }
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
