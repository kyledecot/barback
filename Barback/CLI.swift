import CoreImage
import Foundation
import Cocoa

class CLI {
    let arguments: [String]

    init(arguments: [String]) {
        self.arguments = arguments
    }

    func run(callback: (Bool) -> Void) {
        let inputURL =  URL(fileURLWithPath: self.arguments[1])
        let outputURL = URL(fileURLWithPath: self.arguments[2])
        let data: Data

        do {
          data = try Data(contentsOf: inputURL)
        } catch {
          callback(false)
          return
        }

        let barcode = Barcode(data: data)

        guard let image = barcode.ciImage else {
            callback(false)
            return
        }

        let context = CIContext(options: nil)
        var result: Bool = false
        if let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) {

            do {
                let format = CIFormat.RGBA8

                try context.writePNGRepresentation(of: image, to: outputURL, format: format, colorSpace: colorSpace)

                result = true

            } catch {
                result = false
            }
        } else {
            result = false
        }

        callback(result)
    }
}
