//
//  JEURLResponse.swift
//  
//
//  Created by Jay Zisch on 2023/03/01.
//

import Foundation

struct JEURLResponse<ResponseObject> {
    internal init(object: ResponseObject, urlResponse: URLResponse) {
        self.object = object
        self.urlResponse = urlResponse
        if let httpResponse = urlResponse as? HTTPURLResponse {
            self.httpCode = httpResponse.statusCode
        } else {
            self.httpCode = -1
            //urlResponse.
        }
    }
    
    let object: ResponseObject
    let urlResponse: URLResponse
    let httpCode: Int
    
}
