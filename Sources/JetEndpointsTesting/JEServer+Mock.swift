//
//  File.swift
//  
//
//  Created by Jay Zisch on 2023/03/07.
//

import Foundation
#if canImport(JetEndpoints)
import JetEndpoints

extension JEServer {
    public func pMock(_ endpoint: Endpoints, json: String) throws -> JESetMethod {
        let path = try endpoint.asPathWithQueryParams()
        let config = session.configuration
        config.protocolClasses = [JEMockRequestJSONResponse.self]
        JEMockRequestJSONResponse.json = json
        return JESetMethod(
            session: URLSession(configuration: config),
            url: .init(string: baseURL + "/" + path)!
        )
    }
    
    public func pMock(_ endpoint: Endpoints, data: Data) throws -> JESetMethod {
        let path = try endpoint.asPathWithQueryParams()
        let config = session.configuration
        config.protocolClasses = [JEMockRequestJSONResponse.self]
        JEMockRequestJSONResponse.data = data
        return JESetMethod(
            session: URLSession(configuration: config),
            url: .init(string: baseURL + "/" + path)!
        )
    }
}
#endif
