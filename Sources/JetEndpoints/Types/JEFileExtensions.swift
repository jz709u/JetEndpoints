//
//  FileExtensions.swift
//
//
//  Created by Jay Zisch on 2023/02/22.
//

import Foundation

public enum JEFileExtensions {
    case jpeg
    case png
    case gif
    case tiff
    case pdf
    case vnd
    case txt
    case unknown(JEHTTPMIMEType)
    init(mimetype: JEHTTPMIMEType) {
        switch mimetype {
        case "image/jpeg":
            self = .jpeg
        case "image/png":
            self = .png
        case "image/gif":
            self = .gif
        case "image/tiff":
            self = .tiff
        case "application/pdf":
            self = .pdf
        case "application/vnd":
            self = .vnd
        case "txt/plain":
            self = .txt
        default:
            self = .unknown(mimetype)
        }
    }
}
