import SwiftUI

struct ArtNouveauClockBorder: View {
    var body: some View {
        ZStack {
            Circle().strokeBorder(lineWidth: 2)
            InnerCircle().strokeBorder()
        }
    }
}

private struct InnerCircle: InsettableShape {
    var insetAmount = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addCircle(CGRect(
            x: rect.midX - rect.radius * 90/100,
            y: rect.midY + rect.radius * 10/100 - rect.radius * 90/100,
            width: rect.radius * 2 * 90/100,
            height: rect.radius * 2 * 90/100
        ).insetBy(dx: insetAmount, dy: insetAmount))
        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var circle = self
        circle.insetAmount += amount
        return circle
    }
}

#if DEBUG
struct ArtNouveauClockBorderClockBorder_Previews: PreviewProvider {
    static var previews: some View {
        ArtNouveauClockBorder()
    }
}
#endif
