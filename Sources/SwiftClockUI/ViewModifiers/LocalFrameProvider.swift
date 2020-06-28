import SwiftUI

struct LocalFrameProvider: ViewModifier {
    @Binding var frame: CGRect

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader {
                    Color.clear
                        .preference(key: LocalFramePreferenceKey.self, value: $0.frame(in: .local))
                }
            )
            .onPreferenceChange(LocalFramePreferenceKey.self) {
                frame = $0
            }
    }
}

extension LocalFrameProvider {
    struct LocalFramePreferenceKey: PreferenceKey {
        static var defaultValue: CGRect = .zero

        static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
            if nextValue() != .zero {
                value = nextValue()
            }
        }
    }
}
