//
//  File.swift
//  
//
//  Created by Jay Zisch on 2023/02/23.
//

import Foundation
import Combine

enum JEResponseHandlerErrors: Error {
    case decodeObject
    case other(Error?)
}

protocol JEResponseHandler {
    associatedtype ResponseObject
    var session: URLSession { get }
    var urlRequest: URLRequest { get }
    func asPublisher() -> AnyPublisher<Result<JEURLResponse<ResponseObject>, JEResponseHandlerErrors>, Never>
    func asFailablePublisher() -> AnyPublisher<JEURLResponse<ResponseObject>, JEResponseHandlerErrors>
    func on(completion: @escaping (JEURLResponse<ResponseObject>?, JEResponseHandlerErrors) -> Void) -> URLSessionDataTask
    func webSocket() -> (AnyPublisher<URLSessionWebSocketTask.Message, JEResponseHandlerErrors>, URLSessionWebSocketTask)
    func asyncTask() async throws -> JEURLResponse<ResponseObject>
    func asFuture() -> Future<JEURLResponse<ResponseObject>, JEResponseHandlerErrors>
}
