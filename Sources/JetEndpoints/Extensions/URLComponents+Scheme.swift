//
//  File.swift
//  
//
//  Created by Jay Zisch on 2023/03/06.
//

import Foundation

extension URLComponents {
    var schemeType: JEServerScheme? {
        JEServerScheme(rawValue: self.scheme ?? "")
    }
}
