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
    
    // MARK: schema
    var schema: JEServerSchema { get }
    
    // MARK: authority
    var authority: String { get }
    var userInfo: String? { get }
    var host: String? { get }
    var port: Int? { get }
    
    func p(_ endpoint: Endpoints) -> JESetMethod
}

public extension JEServer {
    var session: URLSession { .shared }
    var baseURL: String { "\(schema.rawValue):\(authority)" }

    // MARK: schema
    var schema: JEServerSchema { .http }
    
    // MARK: authority
    var authority: String { host != nil ? "//" + userInfoPart + host! + portPart : "" }
    var userInfo: String? { nil }
    var userInfoPart: String { userInfo != nil ? userInfo! + "@" : "" }
    var host: String? { nil }
    var port: Int? { nil }
    var portPart: String { port != nil ? ":\(port!)" : "" }
    
    func p(_ endpoint: Endpoints) -> JESetMethod {
        return JESetMethod(
            session: session,
            url: .init(string: baseURL + "/" + endpoint.asPath)!
        )
    }
}


