//
//  Data.File.swift
//  
//
//  Created by Jay Zisch on 2023/03/06.
//

import Foundation
/// https://gist.github.com/Tulakshana/09029d606e092ee93189084dce1f178c
extension Data {
    private static let mimeTypeSignatures: [UInt8 : JEHTTPMIMEType] = [
        0xFF : "image/jpeg",
        0x89 : "image/png",
        0x47 : "image/gif",
        0x49 : "image/tiff",
        0x4D : "image/tiff",
        0x25 : "application/pdf",
        0xD0 : "application/vnd",
        0x46 : "text/plain",
        ]
    
    var mimeType: JEHTTPMIMEType {
        var c: UInt8 = 0
        copyBytes(to: &c, count: 1)
        return Data.mimeTypeSignatures[c] ?? .octet
    }
}
