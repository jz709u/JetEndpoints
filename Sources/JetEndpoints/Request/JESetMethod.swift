//
//  File.swift
//  
//
//  Created by Jay Zisch on 2023/02/23.
//

import Foundation

public class JESetMethod {
    private let session: URLSession
    private let url: URL
    
    init(session: URLSession,
         url: URL) {
        self.session = session
        self.url = url
    }
    /// [Spec](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/GET)
    func get() -> JERequest {
        return .init(
            session: session,
            url: url,
            method: .get,
            body: nil
        )
    }
    /// [Spec](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/HEAD)
    func head() -> JERequest {
        return .init(
            session: session,
            url: url,
            method: .head,
            body: nil
        )
    }
    /// [Spec](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/TRACE)
    func trace() -> JERequest {
        return .init(
            session: session,
            url: url,
            method: .trace,
            body: nil
        )
    }
    /// [Spec](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/OPTIONS)
    func options() -> JERequest {
        .init(session: session,
              url: url,
              method: .options,
              body: nil)
    }
    /// [Spec](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/CONNECT)
    func connect() -> JERequest {
        return .init(
            session: session,
            url: url,
            method: .connect,
            body: nil
        )
    }
    /// [Spec](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/POST)
    func post(body: JEHTTPContent) -> JERequest {
        return .init(
            session: session,
            url: url,
            method: .post,
            body: body
        )
    }
    /// [Spec](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PUT)
    func put(body: JEHTTPContent) -> JERequest {
        return .init(
            session: session,
            url: url,
            method: .put,
            body: body
        )
    }
    /// [Spec](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PATCH)
    func patch(body: JEHTTPContent) -> JERequest {
        return .init(
            session: session,
            url: url,
            method: .patch,
            body: body
        )
    }
    /// [Spec](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/DELETE)
    func delete(body: JEHTTPContent?) -> JERequest {
        return .init(
            session: session,
            url: url,
            method: .delete,
            body: body
        )
    }
}
