import SwiftUI

struct RadiusProvider: ViewModifier {
    @Binding var radius: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader {
                    Color.clear
                        .preference(key: RadiusPreferenceKey.self, value: $0.radius)
                }
            )
            .onPreferenceChange(RadiusPreferenceKey.self) {
                self.radius = $0
            }
    }
}

extension RadiusProvider {
    struct RadiusPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = .zero

        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = max(value, nextValue())
        }
    }
}
