import SwiftUI

extension ClockFaceView {
    struct Mouth: Shape {
        let shape: MouthShape
        private var mouthAnimationShape: Double
        
        init(shape: MouthShape) {
            self.shape = shape
            self.mouthAnimationShape = shape.rawValue
        }
        
        var animatableData: Double {
            get { self.mouthAnimationShape }
            set { self.mouthAnimationShape = newValue }
        }
        
        func path(in rect: CGRect) -> Path {
            let width = rect.width
            let height = rect.height
            guard width > 0, height > 0 else { return Path() }
            
            let margin: CGFloat = 8.0
            
            var path = Path()
            
            let newY = height/2 * (1 - CGFloat(self.mouthAnimationShape))
            path.move(to: CGPoint(x: .zero, y: newY))
            
            let leftTo = CGPoint(x: width/2, y: height/2 * (1 + CGFloat(self.mouthAnimationShape)))
            let leftControl = CGPoint(x: .zero + margin, y: leftTo.y)
            path.addQuadCurve(to: leftTo, control: leftControl)
            
            let rightTo = CGPoint(x: width, y: newY)
            let rightControl = CGPoint(x: width - margin, y: leftTo.y)
            path.addQuadCurve(to: rightTo, control: rightControl)
            
            return path
        }
    }
    
    enum MouthShape: Double {
        case smile = 1.0
        case neutral = 0.0
        case sad = -1.0
    }
}

#if DEBUG
struct Mouth_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ClockFaceView.Mouth(shape: .smile)
                .stroke(style: .init(lineWidth: 6.0, lineCap: .round, lineJoin: .round))
                .padding()
                .frame(width: 100, height: 50)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("Smile")
            
            ClockFaceView.Mouth(shape: .neutral)
                .stroke(style: .init(lineWidth: 6.0, lineCap: .round, lineJoin: .round))
                .padding()
                .frame(width: 100, height: 50)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("Neutral")
            
            ClockFaceView.Mouth(shape: .sad)
                .stroke(style: .init(lineWidth: 6.0, lineCap: .round, lineJoin: .round))
                .padding()
                .frame(width: 100, height: 50)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("Sad")
        }
    }
}
#endif
