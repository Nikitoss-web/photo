import SwiftUI

struct EditableTextView: UIViewRepresentable {
    @Binding var text: String
    var font: UIFont
    var textColor: UIColor
    var onTextChange: ((String) -> Void)?

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = true
        textView.isSelectable = true
        textView.font = font
        textView.textColor = textColor
        textView.delegate = context.coordinator
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = font
        uiView.textColor = textColor
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: EditableTextView

        init(_ parent: EditableTextView) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.onTextChange?(textView.text)
        }
    }
}

