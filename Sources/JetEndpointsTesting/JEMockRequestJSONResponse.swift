//
//  JEMockRequestJSONResponse.swift
//
//
//  Created by Jay Zisch on 2023/03/01.
//

import Foundation
#if canImport(JetEndpoints)

class JEMockRequestJSONResponse: URLProtocol {
    
    enum Errors: Error {
        case mockUnavailable
    }
    
    static var json: String? {
        didSet {
            Self.data = Self.json?.data(using: .utf8)
        }
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
#endif
