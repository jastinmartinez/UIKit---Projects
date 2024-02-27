//
//  CatAppTests.swift
//  CatAppTests
//
//  Created by Jastin on 27/2/24.
//

import XCTest

final class URLSessionHTTPClient {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get(from url: URL) {
        session.dataTask(with: url) { _, _, _ in
            
        }.resume()
    }
}

final class CatAppTests: XCTestCase {

    func test_URLSessionHTTPClient_performRequestFromURL() {
        URLProtocol.registerClass(MockSession.self)
        let sut = URLSessionHTTPClient()
        let anyURL = URL(string: "https://www.any-url.com")!
        
        sut.get(from: anyURL)
    
        let waitForRequest = expectation(description: "wait for async call")
        MockSession.listenToRequest = { requestToReceived in
            XCTAssertEqual(anyURL, requestToReceived.url)
            waitForRequest.fulfill()
        }
        wait(for: [waitForRequest], timeout: 1.0)
        URLProtocol.unregisterClass(MockSession.self)
    }
}

private class MockSession: URLProtocol {
    
    static var listenToRequest: ((URLRequest) -> Void)? = nil
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let stub = MockSession.listenToRequest {
            stub(request)
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() { }
}
