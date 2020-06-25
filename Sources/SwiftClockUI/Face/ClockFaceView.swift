import SwiftUI

struct ClockFaceView: View {
    @Environment(\.clockFaceShown) var isShown

    var body: some View {
        GeometryReader { geometry in
            leftEye(geometry: geometry)
            Eye(move: self.isShown, position: .right)
                .frame(width: geometry.frame(in: .local).height/6, height: geometry.frame(in: .local).height/6)
                .position(
                    x: geometry.frame(in: .local).width/1.5,
                    y: geometry.frame(in: .local).width/3
            )
            Mouth(shape: self.isShown ? .smile : .neutral)
                .stroke(style: .init(lineWidth: 6.0, lineCap: .round, lineJoin: .round))
                .frame(width: geometry.frame(in: .local).width/3, height: geometry.frame(in: .local).height/6)
                .position(
                    x: geometry.frame(in: .local).width/2,
                    y: geometry.frame(in: .local).width/1.3
            )
        }
        .opacity(isShown ? 1 : 0)
        .animation(.easeInOut)
    }

    func leftEye(geometry: GeometryProxy) -> some View {
        Eye(move: isShown, position: .left)
            .frame(width: geometry.circle.height/6)
            .position(
                x: geometry.circle.width/3,
                y: geometry.circle.height/3
            )
    }
}

#if DEBUG
struct ClockFaceSmiling_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle().stroke()
            ClockFaceView()
        }
        .padding()
        .environment(\.clockFaceShown, true)
    }
}
#endif
