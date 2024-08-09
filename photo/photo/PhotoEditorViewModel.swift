import SwiftUI
import UIKit
import PencilKit

class PhotoEditorViewModel: ObservableObject {
    @Published var imageModel: ImageModel?
    @Published var drawing = PKDrawing()
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    @Published var texts: [EditableText] = []
    
    func loadImage(image: UIImage) {
        imageModel = ImageModel(image: image)
    }
    
    func saveImage() {
           guard let imageModel = imageModel else { return }
           let imageSize = imageModel.editedImage.size
           let renderer = UIGraphicsImageRenderer(size: imageSize)

           let combinedImage = renderer.image { context in
               imageModel.editedImage.draw(in: CGRect(origin: .zero, size: imageSize))
               for text in texts {
                   let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: text.attributes.size),
                                     NSAttributedString.Key.foregroundColor: text.attributes.color]
                   let attributedText = NSAttributedString(string: text.content, attributes: attributes)
                   attributedText.draw(at: text.position)
               }
               let drawingImage = drawing.image(from: CGRect(origin: .zero, size: imageSize), scale: UIScreen.main.scale)
               drawingImage.draw(in: CGRect(origin: .zero, size: imageSize))
           }

           UIImageWriteToSavedPhotosAlbum(combinedImage, nil, nil, nil)
           alertItem = AlertItem(title: "Success", message: "Image saved to photo library")
       }
    
    
    @objc private func saveImageCompletion(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        isLoading = false
        if let error = error {
            alertItem = AlertItem(title: "Save Error", message: error.localizedDescription)
        } else {
            alertItem = AlertItem(title: "Success", message: "Image saved successfully.")
        }
    }
    
    func addText(content: String, position: CGPoint, attributes: TextAttributes) {
        let newText = EditableText(content: content, position: position, attributes: attributes)
        texts.append(newText)
    }
    
    func updateText(id: UUID, newText: String) {
        if let index = texts.firstIndex(where: { $0.id == id }) {
            texts[index].content = newText
        }
    }
    
    func updateTextAttributes(id: UUID, attributes: TextAttributes) {
        if let index = texts.firstIndex(where: { $0.id == id }) {
            texts[index].attributes = attributes
        }
    }
    
    func updateTextPosition(id: UUID, position: CGPoint) {
        if let index = texts.firstIndex(where: { $0.id == id }) {
            texts[index].position = position
        }
    }
    
    func applyFilter(_ filterName: String) {    }
}
