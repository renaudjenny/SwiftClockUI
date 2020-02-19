import SwiftUI

struct ClockFaceView: View {
    @EnvironmentObject var viewModel: AnyClockFaceViewModel
    var isShown: Bool {
        viewModel.isClockFaceShown
    }

    var body: some View {
        GeometryReader { geometry in
            Eye(move: self.isShown, position: .left)
                .frame(width: geometry.frame(in: .local).height/6, height: geometry.frame(in: .local).height/6)
                .position(
                    x: geometry.frame(in: .local).width/3,
                    y: geometry.frame(in: .local).width/3
            )
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
}

protocol ClockFaceViewModel {
    var isClockFaceShown: Bool { get }
}

final class AnyClockFaceViewModel: ObservableObject, ClockFaceViewModel {
    @Published private(set) var isClockFaceShown: Bool

    init<T: ClockFaceViewModel>(_ viewModel: T) {
        self.isClockFaceShown = viewModel.isClockFaceShown
    }
}

extension ClockFaceViewModel {
    func eraseToAnyClockFaceViewModel() -> AnyClockFaceViewModel {
        AnyClockFaceViewModel(self)
    }
}

#if DEBUG
struct ClockFaceSmiling_Previews: PreviewProvider {
    static var previews: some View {
        ClockFaceView()
            .environmentObject(App.previewViewModel {
                $0.isClockFaceShown = true
            })
    }
}
#endif
