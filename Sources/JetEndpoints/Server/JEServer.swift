//
//  JESession.swift
//
//
//  Created by Jay Zisch on 2023/02/23.
//

import Foundation

public protocol JEServer {
    associatedtype Endpoints: JEServerPaths
    var session: URLSession { get }
    var baseURL: String { get }

    // MARK: scheme

    var scheme: JEServerScheme { get }

    // MARK: authority

    var authority: String { get }
    var userInfo: String? { get }
    var host: String? { get }
    var port: Int? { get }

    func p(_ endpoint: Endpoints) throws -> JESetMethod
    func pMock(_ endpoint: Endpoints, json: String) throws -> JESetMethod
}

public extension JEServer {
    var session: URLSession { .shared }
    var baseURL: String { "\(scheme.rawValue):\(authority)" }

    // MARK: scheme

    var scheme: JEServerScheme { .http }

    // MARK: authority

    var authority: String { host != nil ? "//" + userInfoPart + host! + portPart : "" }
    var userInfo: String? { nil }
    var userInfoPart: String { userInfo != nil ? userInfo! + "@" : "" }
    var host: String? { nil }
    var port: Int? { nil }
    var portPart: String { port != nil ? ":\(port!)" : "" }

    func p(_ endpoint: Endpoints) throws -> JESetMethod {
        let path = try endpoint.asPath()
        return JESetMethod(
            session: session,
            url: .init(string: baseURL + "/" + path)!
        )
    }
    
    func pMock(_ endpoint: Endpoints, json: String) throws -> JESetMethod {
        let path = try endpoint.asPath()
        let config = session.configuration
        config.protocolClasses = [JEMockRequestJSONResponse.self]
        JEMockRequestJSONResponse.json = json
        return JESetMethod(
            session: URLSession(configuration: config),
            url: .init(string: baseURL + "/" + path)!
        )
    }
}

