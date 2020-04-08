import SwiftUI

extension Path {
    mutating func addVerticalMirror(in rect: CGRect) {
        let mirror = self
            .applying(.init(scaleX: -1, y: 1))
            .applying(.init(translationX: rect.width, y: 0))
        #if os(iOS)
        let reversedPath = Path(UIBezierPath(cgPath: mirror.cgPath).reversing().cgPath)
        #else
        let reversedPath = Path(NSBezierPath(cgPath: mirror.cgPath).reversed.cgPath)
        #endif

        reversedPath.forEach {
            switch $0 {
            case .move: break
            case .closeSubpath: break
            case .line(to: let to):
                self.addLine(to: to)
            case .quadCurve(to: let to, control: let control):
                self.addQuadCurve(to: to, control: control)
            case .curve(to: let to, control1: let control1, control2: let control2):
                self.addCurve(to: to, control1: control1, control2: control2)
            }
        }

        self.closeSubpath()
    }
}
