//
//  File.swift
//
//
//  Created by Jay Zisch on 2023/02/27.
//

import Foundation

public extension URLRequest {
    var content: JEHTTPContent? {
        set {
            contentType = newValue?.type
            httpBody = newValue?.body
        }
        get {
            guard let contentType = contentType,
                  let body = httpBody else { return nil }
            return JEHTTPContent(
                type: contentType,
                body: body
            )
        }
    }
}
