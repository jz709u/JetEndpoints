//
//  File.swift
//
//
//  Created by Jay Zisch on 2023/02/21.
//

#if os(macOS)

    import Cocoa

    // Step 1: Typealias UIImage to NSImage
    typealias UIImage = NSImage

    // Step 2: You might want to add these APIs that UIImage has but NSImage doesn't.
    private extension NSImage {
        var cgImage: CGImage? {
            var proposedRect = CGRect(origin: .zero, size: size)

            return cgImage(forProposedRect: &proposedRect,
                           context: nil,
                           hints: nil)
        }
    }

    extension NSBitmapImageRep {
        var png: Data? { representation(using: .png, properties: [:]) }
    }

    extension Data {
        var bitmap: NSBitmapImageRep? { NSBitmapImageRep(data: self) }
    }

    extension NSImage {
        func pngData() -> Data? { tiffRepresentation?.bitmap?.png }
    }

    extension NSImage {
        func jpegData(compressionQuality: CGFloat) -> Data? {
            func jpegDataFrom(image: NSImage) -> Data {
                let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
                let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
                let jpegData = bitmapRep.representation(
                    using: NSBitmapImageRep.FileType.jpeg,
                    properties: [.compressionFactor: compressionQuality]
                )!
                return jpegData
            }
            let data = jpegDataFrom(image: self)
            return data
        }
    }

#endif
