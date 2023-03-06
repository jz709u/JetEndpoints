//
//  JERequest.swift
//
//
//  Created by Jay Zisch on 2023/02/22.
//

import Combine
import Foundation

public typealias JEQueryParam = (key: String, value: String)

public class JERequest {
    private var method: JEHTTPMethod
    private var url: URL
    private var session: URLSession
    private var body: JEHTTPContent?

    init(
        session: URLSession,
        url: URL,
        method: JEHTTPMethod,
        body: JEHTTPContent?
    ) {
        self.url = url
        self.method = method
        self.session = session
        self.body = body
    }

    func with(queryParams: [JEQueryParam]) -> Self {
        var comps = URLComponents(string: url.absoluteString)
        let params = queryParams.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        comps?.queryItems = params
        if let url = comps?.url {
            self.url = url
        }
        return self
    }

    private func asRequest() -> URLRequest {
        var request = URLRequest(url: url)
        if let body = body {
            request.httpBody = body.body
            request.contentType = body.type
        }
        request.httpMethodValue = method
        return request
    }

    func response<ResponseObject>(
        _: ResponseObject.Type
    ) -> some JEResponseHandler where ResponseObject: Decodable {
        JEDefaultDecodableResponseHandler<ResponseObject>(
            session: session,
            urlRequest: asRequest()
        )
    }

    func responseJSON() -> some JEJSONResponseHandler {
        JEDefaultJSONResponseHandler(
            session: session,
            urlRequest: asRequest()
        )
    }
}
