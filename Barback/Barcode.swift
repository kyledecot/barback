import CoreImage
import Cocoa

struct Barcode {
    let data: Data

    var ciImage: CIImage? {
        guard let filter = CIFilter(name: "CIPDF417BarcodeGenerator") else {
            return nil
        }

        filter.setValue(data, forKey: "inputMessage")

        return filter.outputImage
    }
}
