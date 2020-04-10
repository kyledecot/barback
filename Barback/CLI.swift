import CoreImage
import Foundation
import Cocoa

class CLI {
    let arguments: [String]

    init(arguments: [String]) {
        self.arguments = arguments
    }

    func savePNG(image: NSImage, path:URL) throws {
        let imageRep = NSBitmapImageRep(data: image.tiffRepresentation!)
        let pngData = imageRep?.representation(using: NSBitmapImageRep.FileType.png, properties: [:])
        
        try pngData!.write(to: path)
    }
    
    func run(callback: (Bool) -> Void) {
        let desktop = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first
        let inputURL = desktop?.appendingPathComponent(self.arguments[1])
        let outputURL = desktop?.appendingPathComponent(self.arguments[2])
        let data = try! NSString(contentsOf: inputURL!, encoding: String.Encoding.utf8.rawValue).data(using: String.Encoding.ascii.rawValue)!
        
        let barcode = Barcode(data: data)
        
        guard let image = barcode.nsImage else {
            callback(false)
            return
        }
                
        do {
            try savePNG(image: image, path: outputURL!)
        } catch {
            callback(false)
            return
        }
    
        callback(true)
    }
}
