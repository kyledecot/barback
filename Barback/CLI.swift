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
        let context = CIContext(options: nil)

        if let image = barcode.ciImage, let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) {
            do {
                let format = CIFormat.RGBA8

                try context.writePNGRepresentation(of: image, to: outputURL, format: format, colorSpace: colorSpace)

                callback(true)
                return
            } catch {}
        }

        callback(false)
    }
}
