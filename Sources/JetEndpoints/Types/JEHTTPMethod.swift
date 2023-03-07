//
//  File.swift
//
//
//  Created by Jay Zisch on 2023/02/23.
//

import Foundation

/// [Spec](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods)
public enum JEHTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
    case patch = "PATCH"
}
