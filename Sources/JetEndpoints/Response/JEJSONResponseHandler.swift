//
//  File.swift
//  
//
//  Created by Jay Zisch on 2023/03/02.
//

import Foundation
import Combine

struct JEDefaultJSONResponseHandler: JEJSONResponseHandler {
    var session: URLSession
    var urlRequest: URLRequest
}

protocol JEJSONResponseHandler: JEResponseHandler where ResponseObject == [String: Any] { }

extension JEJSONResponseHandler {
    func asPublisher() -> AnyPublisher<Result<JEURLResponse<ResponseObject>, JEResponseHandlerErrors>, Never> {
        session.dataTaskPublisher(for: urlRequest)
            .tryMap { try Self.decodeResponse(data: $0, response: $1) }
            .map { Result<JEURLResponse<ResponseObject>, JEResponseHandlerErrors>.success($0) }
            .catch { Just(.failure(.other($0))) }
            .eraseToAnyPublisher()
    }
    
    func asFailablePublisher() -> AnyPublisher<JEURLResponse<ResponseObject>, JEResponseHandlerErrors> {
        session.dataTaskPublisher(for: urlRequest)
            .tryMap { try Self.decodeResponse(data: $0, response: $1) }
            .mapError { JEResponseHandlerErrors.other($0) }
            .eraseToAnyPublisher()
    }
    
    func on(completion: @escaping (JEURLResponse<ResponseObject>?, JEResponseHandlerErrors) -> Void) -> URLSessionDataTask {
        session.dataTask(
            with: urlRequest,
            completionHandler: { (data, response, error) in
                let _error = JEResponseHandlerErrors.other(error)
                if let data = data,
                   let response = response,
                   let object = try? Self.decodeResponse(data: data, response: response) {
                    completion(object, _error)
                } else {
                    completion(nil, _error)
                }
            }
        )
    }
    
    func webSocket() -> (AnyPublisher<URLSessionWebSocketTask.Message, JEResponseHandlerErrors>, URLSessionWebSocketTask) {
        let task = session.webSocketTask(with: urlRequest)
        
        let subject = PassthroughSubject<URLSessionWebSocketTask.Message, JEResponseHandlerErrors>()
        task.receive { result in
            switch result {
            case .success(let success):
                subject.send(success)
            case .failure(let failure):
                subject.send(completion: .failure(JEResponseHandlerErrors.other(failure)))
            }
        }
        task.resume()
        
        return (subject.eraseToAnyPublisher(), task)
    }
    
    func asyncTask() async throws -> JEURLResponse<ResponseObject>{
        let (data, response) = try await session.data(for: urlRequest)
        return try Self.decodeResponse(data: data, response: response)
    }
    
    func asFuture() -> Future<JEURLResponse<ResponseObject>, JEResponseHandlerErrors> {
        Future { promise in
            Task {
                do {
                    promise(.success(try await self.asyncTask()))
                } catch {
                    promise(.failure(JEResponseHandlerErrors.other(error)))
                }
            }
        }
    }
    
    static func decodeResponse(data: Data, response: URLResponse) throws -> JEURLResponse<ResponseObject> {
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw JEResponseHandlerErrors.decodeObject
        }
        return JEURLResponse<ResponseObject>(object: json, urlResponse: response)
    }
}
