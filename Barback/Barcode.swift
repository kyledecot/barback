import CoreImage
import Cocoa

class Barcode {
    let data: Data
    let size = NSSize(width: 500, height: 100)
    
    var nsImage: NSImage? {
        guard let cgImage = cgImage else {
            return nil
        }
        
        return NSImage(cgImage: cgImage, size: size)
    }
    
    var ciImage: CIImage? {
        guard let filter = CIFilter(name: "CIPDF417BarcodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)
            
        return filter.outputImage?.transformed(by: transform)
    }
    
    var cgImage: CGImage? {
        guard let ciImage = ciImage else {
            return nil
        }
       
        let context = CIContext(options: nil)

        return context.createCGImage(ciImage, from: ciImage.extent)
    }
    
    init(data: Data) {
        self.data = data
    }
}
