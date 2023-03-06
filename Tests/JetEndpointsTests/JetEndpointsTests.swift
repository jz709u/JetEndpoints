import XCTest
@testable import JetEndpoints
import Combine
import Quick
import Nimble

class TestServer: JEServer {
    var host: String? { "127.0.0.1" }
    var port: Int? { 5000 }
//    var session: URLSession {
//        let configuration = URLSessionConfiguration.ephemeral
//        configuration.protocolClasses = [MockRequestJSONResponse.self]
//        return URLSession(configuration: configuration)
//    }
    enum Endpoints: String, JEServerPaths {
        case fun
    }
}

//class MockRequestJSONResponse: URLProtocol {
//
//    static var json: JSON?
//
//  override class func canInit(with request: URLRequest) -> Bool {
//    // To check if this protocol can handle the given request.
//    return true
//  }
//
//  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
//    // Here you return the canonical version of the request but most of the time you pass the orignal one.
//    return request
//  }
//
//  override func startLoading() {
//      request.
//      guard let url = request.url {
//                  let path: String
//                  if let queryString = url.query {
//                      path = url.relativePath + "?" + queryString
//                  } else {
//                      path = url.relativePath
//                  }
//                  let data = MockURLProtocol.mockData[path]!
//                  client?.urlProtocol(self, didLoad: data)
//                  client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .allowed)
//              }
//              client?.urlProtocolDidFinishLoading(self)
//  }
//
//  override func stopLoading() {
//    // This is called if the request gets canceled or completed.
//  }
//}

final class JetEndpointsTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //XCTAssertEqual(JWeb().text, "Hello, World!")
    }
    
    func testImagePost() throws {
        
    
        let imageData = try loadImage(named: "jpeg-home")
        var bag = Set<AnyCancellable>()
        
        let expecation = expectation(description: "some")
        expecation.assertForOverFulfill = false
        
        let server = TestServer()
        server
            .p(.fun)
            .post(body: .init(image: imageData, imageType: .jpg)!)
            .responseJSON()
            .asFuture()
            .sink(receiveCompletion: { error in
                switch error {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("error \(error)")
                }
                expecation.fulfill()
            }, receiveValue: { response in
                print("response: \(response)")
                expecation.fulfill()
            })
            .store(in: &bag)
        
        wait(for: [expecation], timeout: 10)
    }
    
    func loadImage(named name: String, _type: String = "jpg") throws -> UIImage {
        let bundle = Bundle.module
        guard let path = bundle.path(forResource: name, ofType: _type) else {
            throw NSError(domain: "loadImage", code: 1, userInfo: nil)
        }
        guard let image = UIImage(contentsOfFile: path) else {
            throw NSError(domain: "loadImage", code: 2, userInfo: nil)
        }
        return image
    }
}
