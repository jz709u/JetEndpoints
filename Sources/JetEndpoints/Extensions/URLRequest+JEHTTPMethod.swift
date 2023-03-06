//
//  URLRequest+JEHTTPMethod.swift
//  
//
//  Created by Jay Zisch on 2023/02/23.
//

import Foundation

public extension URLRequest {
    var httpMethodValue: JEHTTPMethod? {
        set { self.httpMethod = newValue?.rawValue }
        get { JEHTTPMethod(rawValue: self.httpMethod ?? "") }
    }
}
