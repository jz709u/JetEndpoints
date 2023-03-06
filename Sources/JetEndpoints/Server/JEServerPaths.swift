//
//  File.swift
//  
//
//  Created by Jay Zisch on 2023/03/02.
//

import Foundation

public protocol JEServerPaths: RawRepresentable where RawValue == String {
    var asPath: String { get }
}
/// jay_other_one$x_1@y_2@z_4,
public extension JEServerPaths {
    var asPath: String {
        rawValue.replacingOccurrences(of: "_", with: "/")
    }
}
