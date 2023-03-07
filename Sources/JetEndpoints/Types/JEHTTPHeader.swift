//
//  JEHTTPHeader.swift
//
//
//  Created by Jay Zisch on 2023/02/16.
//

import Foundation

public enum JEHTTPHeader: String {
    case contentType = "Content-Type"
    case accept = "Accept"
    case authorization = "Authorization"
    /// [docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/WWW-Authenticate)
    case wwwAuthentication = "WWW-Authentication"
}
