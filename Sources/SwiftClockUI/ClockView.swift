import SwiftUI

public struct ClockView: View {
    @EnvironmentObject var viewModel: AnyClockViewModel
    static let borderWidthRatio: CGFloat = 1/70

    public init() { }

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ClockBorderView()
                IndicatorsView()
                Arms()
                ClockFaceView()
            }
            .frame(width: geometry.localDiameter, height: geometry.localDiameter)
            .fixedSize()
            .onTapGesture(count: 3, perform: self.showClockFace)
        }
    }

    private func showClockFace() {
        viewModel.showClockFace()
        viewModel.delayClockFaceHidding()
    }
}

protocol ClockViewModel {
    var isClockFaceShown: Bool { get }
    var showClockFace: () -> Void { get }
    var delayClockFaceHidding: () -> Void { get }
}

final class AnyClockViewModel: ObservableObject, ClockViewModel {
    @Published private(set) var isClockFaceShown: Bool
    let showClockFace: () -> Void
    let delayClockFaceHidding: () -> Void

    init<T: ClockViewModel>(_ viewModel: T) {
        self.isClockFaceShown = viewModel.isClockFaceShown
        self.showClockFace = viewModel.showClockFace
        self.delayClockFaceHidding = viewModel.delayClockFaceHidding
    }
}

extension ClockViewModel {
    func eraseToAnyClockViewModel() -> AnyClockViewModel {
        AnyClockViewModel(self)
    }
}

#if DEBUG
struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView().padding()
            .modifier(PreviewEnvironmentObject())
    }
}

struct ClockViewWithFace_Previews: PreviewProvider {
    static var previews: some View {
        ClockView().padding()
            .modifier(PreviewEnvironmentObject {
                $0.isClockFaceShown = true
            })
    }
}

struct ClockViewArtNouveauStyle_Previews: PreviewProvider {
    static var previews: some View {
        ClockView().padding()
            .modifier(PreviewEnvironmentObject {
                $0.clockStyle = .artNouveau
                $0.hourAngle = .degrees(20)
            })
    }
}

struct ClockViewDrawingStyle_Previews: PreviewProvider {
    static var previews: some View {
        ClockView().padding()
            .modifier(PreviewEnvironmentObject {
                $0.clockStyle = .drawing
                $0.hourAngle = .degrees(20)
            })
    }
}
#endif
