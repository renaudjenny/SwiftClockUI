import SwiftUI

public struct Random {
    var controlRatio = (
        leftX: { CGFloat.random(in: 0.1...1) },
        leftY: { CGFloat.random(in: 0.1...1) },
        rightX: { CGFloat.random(in: 0.1...1) },
        rightY: { CGFloat.random(in: 0.1...1) }
    )

    var borderMarginRatio = (
        maxMargin: { CGFloat.random(in: 0...$0) },
        angleMargin: { Double.random(in: 0...1/3) }
    )

    private static let angles: [Angle] = [.zero, .degrees(-5), .degrees(5)]
    var angle: () -> Angle? = Self.angles.randomElement
    private static let scales: [CGFloat] = [1, 1.1, 0.9]
    var scale: () -> CGFloat? = Self.scales.randomElement
}

public struct ClockRandomKey: EnvironmentKey {
    public static let defaultValue: Random = .random
}

public extension EnvironmentValues {
    var clockRandom: Random {
        get { self[ClockRandomKey.self] }
        set { self[ClockRandomKey.self] = newValue }
    }
}

public extension Random {
    struct ControlRatio {
        let leftX: CGFloat
        let leftY: CGFloat
        let rightX: CGFloat
        let rightY: CGFloat

        init(random: Random) {
            self.leftX = random.controlRatio.leftX()
            self.leftY = random.controlRatio.leftY()
            self.rightX = random.controlRatio.rightX()
            self.rightY = random.controlRatio.rightY()
        }
    }
}

extension Random {
    static var random = Random()
    static var fixed: Random {
        Random(
            controlRatio: (
                leftX: { 0.5 },
                leftY: { 0.6 },
                rightX: { 0.7 },
                rightY: { 0.8 }
            ),
            borderMarginRatio: (
                maxMargin: { $0 },
                angleMargin: { 1/3 }
            ),
            angle: { .degrees(5) },
            scale: { 1 }
        )
    }
}
