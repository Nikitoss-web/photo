import UIKit
import CoreImage

class ImageModel: ObservableObject {
    @Published var image: UIImage
    @Published var editedImage: UIImage
    
    init(image: UIImage) {
        self.image = image
        self.editedImage = image
    }
    
    func addText(_ text: String, at point: CGPoint, attributes: [NSAttributedString.Key: Any]) {
        editedImage = image.drawText(text, at: point, attributes: attributes) ?? image
    }
    
    func applyFilter(_ filterName: String) {
        editedImage = image.applyFilter(filterName) ?? image
    }
}
