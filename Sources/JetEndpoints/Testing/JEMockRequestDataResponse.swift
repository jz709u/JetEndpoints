//
//  File.swift
//  
//
//  Created by Jay Zisch on 2023/03/06.
//

import Foundation

class JEMockRequestDataResponse: URLProtocol {
    
    enum Errors: Error {
        case mockUnavailable
    }
    
    static var data: Data?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let data = Self.data {
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .allowed)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        Self.data = nil
    }
}
