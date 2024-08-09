import SwiftUI

struct EditableText: Identifiable {
    var id = UUID()
    var content: String
    var position: CGPoint
    var attributes: TextAttributes
}

struct TextAttributes {
    var size: CGFloat
    var color: Color
}

