//
//  JEMockServerType.swift
//  
//
//  Created by Jay Zisch on 2023/03/07.
//

import Foundation
#if canImport(JetEndpoints)
import JetEndpoints

public class JEMockServerType<Endpoints: JEServerPaths, Mocks: JEMockEndpoints>: JEServerType<Endpoints> where Mocks.Endpoints == Endpoints {
    public override var session: URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [JEMockAllServersEndpointsResponse<Endpoints>.self]
        
        //JEMockAllServersEndpointsResponse
        
        //JEMockAllServersEndpointsResponse.
        return URLSession(configuration: config)
    }
}

public protocol JEMockEndpoints {
    associatedtype Endpoints: JEServerPaths
    static var endpointToMock: [Endpoints: (Data?, URLResponse?, Error?)] { get }
}
#endif
