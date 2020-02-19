import SwiftUI

// TODO: I'm not satisfied of that, would rather have another EnvironmentObject or something instead
struct World {
    var isAnimationDisabled = false

    var randomControlRatio = (
        leftX: { CGFloat.random(in: 0.1...1) },
        leftY: { CGFloat.random(in: 0.1...1) },
        rightX: { CGFloat.random(in: 0.1...1) },
        rightY: { CGFloat.random(in: 0.1...1) }
    )

    var randomBorderMarginRatio = (
        maxMargin: { CGFloat.random(in: 0...$0) },
        angleMargin: { Double.random(in: 0...1/3) }
    )

    private static let angles: [Angle] = [.zero, .degrees(-5), .degrees(5)]
    var randomAngle: () -> Angle? = Self.angles.randomElement
    private static let scales: [CGFloat] = [1, 1.1, 0.9]
    var randomScale: () -> CGFloat? = Self.scales.randomElement
}

var Current = World()
