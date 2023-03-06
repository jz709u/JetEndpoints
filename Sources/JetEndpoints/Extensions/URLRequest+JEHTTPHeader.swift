//
//  URLRequest+JEHTTPHeader.swift
//  
//
//  Created by Jay Zisch on 2023/02/22.
//

import Foundation

public extension URLRequest {
    var httpHeaders: [JEHTTPHeader: String] {
        set {
            allHTTPHeaderFields = newValue
                .reduce(into: [String: String](), { result, keyValue in
                    result[keyValue.key.rawValue] = keyValue.value
                })
        }
        get {
            self.allHTTPHeaderFields?
                .reduce(into: [JEHTTPHeader: String](), { result, keyValue in
                    guard let type = JEHTTPHeader(rawValue: keyValue.key) else { return }
                    result[type] = keyValue.value
                }) ?? [JEHTTPHeader: String]()
        }
    }
}
