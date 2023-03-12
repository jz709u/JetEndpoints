import Combine
@testable import JetEndpoints
import JetEndpointsTesting
import Nimble
import Quick
import XCTest

final class JetEndpointsTests: XCTestCase {
    
    class TestServer: JEServer {
        var host: String? { "127.0.0.1" }
        var port: Int? { 5000 }
        
        enum Endpoints: String, JEServerPaths {
            case fun
        }
    }

    func testExample() throws {
        
        let image = try loadImage(named: "jpeg-home")
        
        struct Mock: JEMockEndpoints {
            static var endpointToMock: [JetEndpointsTests.TestServer.Endpoints : (Data?, URLResponse?, Error?)] {
                [
                    .fun: (Data(),
                           HTTPURLResponse(url: URL(string: "")!, statusCode: 100, httpVersion: nil, headerFields: nil)!,
                          nil)
                ]
            }
        }
        
        let serv: JEMockServerType<TestServer.Endpoints, Mock> = "https://127.0.0.1:5000"
        
        var bag = Set<AnyCancellable>()

        let expecation = expectation(description: "some")
        expecation.assertForOverFulfill = false
        
        let server: JEServerType<TestServer.Endpoints> = "https://127.0.0.1:5000"

        try server
            .p(.fun)
            .post(body: .init(image: image, imageType: .jpg)!)
            .responseJSON()
            .asFuture()
            .sink(receiveCompletion: { error in
                switch error {
                case .finished:
                    print("finished")
                case let .failure(error):
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

    func testImagePost() throws {
        let imageData = try loadImage(named: "jpeg-home")
        var bag = Set<AnyCancellable>()

        let expecation = expectation(description: "some")
        expecation.assertForOverFulfill = false

        let server = TestServer()
        try server
            .pMock(.fun, json: """
            {
            "hello" : "world"
            }
            """)
            .post(body: .init(image: imageData, imageType: .jpg)!)
            .responseJSON()
            .asFuture()
            .sink(receiveCompletion: { error in
                switch error {
                case .finished:
                    print("finished")
                case let .failure(error):
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
