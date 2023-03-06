//
//  JEHTTPMIMEType.swift
//  ManagerOne
//
//  Created by Jay Zisch on 2023/02/16.
//

import Foundation

// https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types
public struct JEHTTPMIMEType: RawRepresentable, ExpressibleByStringLiteral {
    
    // MARK: - ExpressibleByStringLiteral
    public typealias StringLiteralType = String
    
    
    // MARK: - RawRepresentable
    public var rawValue: String {
        unknownType ?? "\(type.rawValue)/\(subType)\(parameter.count > 0 ? ";\(parameter.first!.key)=\(parameter.first!.value)" : "")"
    }
    public typealias RawValue = String
    
    
    // https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types
    public enum MajorType: String {
        // MARK: Types
        case application
        case audio
        case example
        case font
        case image
        case model
        case text
        case video
        
        // MARK: Multi part types
        case message
        case multipart
        
        case unknown
    }
    
    public var type: MajorType = .unknown
    public var subType: String = "" // subtypes: https://www.iana.org/assignments/media-types/media-types.xhtml#video
    public var unknownType: String?
    public var parameter: [String: String] = [:]
    
   
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
    
    public init(rawValue: String) {
        func parseMajorAndSubTypes(value: String) -> (MajorType, String)? {
            let majorMinor = value.components(separatedBy: "/")
            guard majorMinor.count == 2,
                  let major = MajorType(rawValue: majorMinor[0]) else { return nil }
            return (major, majorMinor[1])
        }
        
        func parseParameters(value: String) -> [String: String] {
            let nameValue = value.components(separatedBy: "=")
            guard nameValue.count == 2 else { return [:] }
            return [nameValue[0]: nameValue[1]]
        }
        
        let comps = rawValue.components(separatedBy: ";")
        
        if comps.count == 2 {
            if let (type, subType) = parseMajorAndSubTypes(value: comps[0]) {
                self.type = type
                self.subType = subType
            }
            parameter = parseParameters(value: comps[1])
        } else if comps.count == 1 {
            if let (type, subType) = parseMajorAndSubTypes(value: comps[0]) {
                self.type = type
                self.subType = subType
            }
        }
    }
}

