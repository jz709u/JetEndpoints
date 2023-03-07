//
//  File.swift
//
//
//  Created by Jay Zisch on 2023/03/02.
//

import Foundation

public enum JEServerPathsErrors: Error {
    case invalidPath
}

public protocol JEServerPaths: RawRepresentable where RawValue == String {
    func asPath() throws -> String
}

/// this: jay_other_one__x_1__y_2__z_4,
///
/// is equivalent to:
///
/// jay/other/one?x=1&y=2&z=4
public extension JEServerPaths {
    func asPath() throws -> String {
        let trimmedValue = rawValue.trimmingCharacters(in: CharacterSet(arrayLiteral: "_"))
        let comps = trimmedValue.components(separatedBy: "__")
        if comps.count <= 1 {
            return trimmedValue.replacingOccurrences(of: "_", with: "/")
        } else {
            let path = comps[0].replacingOccurrences(of: "_", with: "/")
            
            var queryParams = "?"
            let params = Array(comps.dropFirst())

            for i in 0..<params.count {
                queryParams += params[i].replacingOccurrences(of: "_", with: "=")
                if i != params.count - 1 {
                    queryParams += "&"
                }
            }
            return path + queryParams
        }
    }
}
