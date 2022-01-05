import SwiftUI

func withSlightyDelayedAnimation<Result>(
    _ animation: Animation? = .default,
    _ body: @escaping () throws -> Result,
    errorHandler: @escaping (Error) -> Void = { _ in }
) rethrows {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        do {
            _ = try withAnimation(animation, body)
        } catch {
            errorHandler(error)
        }
    }
}
