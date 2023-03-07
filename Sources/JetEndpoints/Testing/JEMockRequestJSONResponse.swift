//
//  JEMockRequestJSONResponse.swift
//
//
//  Created by Jay Zisch on 2023/03/01.
//

import Foundation

class JEMockRequestJSONResponse: URLProtocol {
    
    enum Errors: Error {
        case mockUnavailable
    }
    
    static var json: String?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let data = Self.json?.data(using: .utf8) {
            client?.urlProtocol(self, didLoad: data)
        } else {
            client?.urlProtocol(self, didFailWithError: Errors.mockUnavailable)
        }
        client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .allowed)
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        Self.json = nil
    }
}
