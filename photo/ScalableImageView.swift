import SwiftUI

struct ScalableImageView: View {
    @Binding var image: UIImage
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Double = 0.0
    @State private var translation: CGSize = .zero
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaleEffect(scale)
            .rotationEffect(.degrees(rotation))
            .offset(translation)
            .gesture(
                SimultaneousGesture(
                    MagnificationGesture()
                        .onChanged { value in
                            scale = value.magnitude
                        },
                    RotationGesture()
                        .onChanged { value in
                            rotation = value.degrees
                        }
                )
            )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        translation = value.translation
                    }
            )
    }
}
