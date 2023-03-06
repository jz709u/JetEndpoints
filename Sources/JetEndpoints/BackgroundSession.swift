//
//  File.swift
//
//
//  Created by Jay Zisch on 2023/02/21.
//

import Foundation

// https://developer.apple.com/documentation/foundation/url_loading_system/downloading_files_in_the_background
class URLSessions: NSObject, URLSessionDelegate {
    enum Sessions: String {
        case background
    }

    lazy var backgroundSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: Sessions.background.rawValue)
        config.isDiscretionary = true
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
}
