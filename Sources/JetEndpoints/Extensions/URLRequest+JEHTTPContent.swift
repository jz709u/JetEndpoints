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
            self.contentType = newValue?.type
            self.httpBody = newValue?.body
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
