//
//  HTTPMIMEType+Common.swift
//  ManagerOne
//
//  Created by Jay Zisch on 2023/02/16.
//

import Foundation

extension JEHTTPMIMEType {
    static let json: JEHTTPMIMEType = "application/json"
    static let octet: JEHTTPMIMEType = "application/octet-stream"
    static let pdf: JEHTTPMIMEType = "application/pdf"
    static let jpeg: JEHTTPMIMEType = "image/jpeg"
    static let png: JEHTTPMIMEType = "image/png"
    static let csv: JEHTTPMIMEType = "text/csv"
    static let avi: JEHTTPMIMEType = "video/x-msvideo"
    static let gif: JEHTTPMIMEType = "image/gif"
    static func multiFormData(with boundary: String) -> JEHTTPMIMEType {
        return .init(rawValue: "multipart/form-data; boundary=\(boundary)")
    }
}
