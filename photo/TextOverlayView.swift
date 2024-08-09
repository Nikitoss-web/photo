import SwiftUI

struct TextOverlayView: View {
    @Binding var text: String
    var attributes: TextAttributes
    @Binding var position: CGPoint

    var body: some View {
        Text(text)
            .font(.system(size: attributes.size))
            .foregroundColor(Color(attributes.color))
            .position(position)
    }
}

