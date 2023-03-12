//
//  JEServerType.swift
//  
//
//  Created by Jay Zisch on 2023/03/06.
//

import Foundation

open class JEServerType<Endpoints: JEServerPaths>: JEServer, ExpressibleByStringLiteral, RawRepresentable {
    
    public var rawValue: String
    public typealias RawValue = String
    public typealias StringLiteralType = String
    
    
    public required convenience init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
    public required init(rawValue: String) {
        self.rawValue = rawValue
        guard let comps = URLComponents(string: rawValue),
        let scheme = comps.schemeType,
        let host = comps.host else {
            fatalError("no comps")
        }
        self._scheme = scheme
        self._host = host
        self._port = comps.port
        self._userInfo = comps.user
    }
    
    open var session: URLSession { .shared }
    public var baseURL: String { "\(scheme.rawValue):\(authority)" }

    // MARK: scheme

    public var scheme: JEServerScheme { _scheme }
    var _scheme: JEServerScheme

    // MARK: authority

    public var authority: String { host != nil ? "//" + userInfoPart + host! + portPart : "" }

    public var userInfo: String? { _userInfo }
    var _userInfo: String?
    var userInfoPart: String { userInfo != nil ? userInfo! + "@" : "" }
    
    public var host: String? { _host }
    let _host: String
    
    public var port: Int? { _port }
    let _port: Int?
    var portPart: String { port != nil ? ":\(port!)" : "" }
}

