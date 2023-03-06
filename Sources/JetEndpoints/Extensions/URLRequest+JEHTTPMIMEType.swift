//
//  File.swift
//
//
//  Created by Jay Zisch on 2023/02/22.
//

import Foundation

public extension URLRequest {
    var contentType: JEHTTPMIMEType? {
        set {
            httpHeaders[.contentType] = newValue?.rawValue
        }
        get {
            guard let type = httpHeaders[.contentType] else { return nil }
            return JEHTTPMIMEType(rawValue: type)
        }
    }
}
