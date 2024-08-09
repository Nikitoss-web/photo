import UIKit
import CoreImage

extension UIImage {
    func drawText(_ text: String, at point: CGPoint, attributes: [NSAttributedString.Key: Any]) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(origin: .zero, size: size))
        
        let textRect = CGRect(origin: point, size: size)
        (text as NSString).draw(in: textRect, withAttributes: attributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func applyFilter(_ filterName: String) -> UIImage? {
        guard let ciImage = CIImage(image: self),
              let filter = CIFilter(name: filterName) else { return nil }
        
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        guard let outputCIImage = filter.outputImage,
              let cgImage = CIContext().createCGImage(outputCIImage, from: outputCIImage.extent) else { return nil }
        
        return UIImage(cgImage: cgImage)
    }
}
