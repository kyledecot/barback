import CoreImage
import Cocoa

class Barcode {
    let data: Data

    var ciImage: CIImage? {
        guard let filter = CIFilter(name: "CIPDF417BarcodeGenerator") else {
            return nil
        }

        filter.setValue(data, forKey: "inputMessage")

        return filter.outputImage
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

    func nsImage(width: Int, height: Int) -> NSImage? {
        guard let cgImage = cgImage else {
            return nil
        }

        return NSImage(cgImage: cgImage, size: NSSize(width: width, height: height))
    }
}
