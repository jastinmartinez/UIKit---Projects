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
    
    func get(from url: URL, completion: @escaping (Data) -> Void = {_ in }) {
        session.dataTask(with: url) { data, _, _ in
            if let data = data {
                completion(data)
            }
        }.resume()
    }
}

final class CatAppTests: XCTestCase {

    func test_getFromURL_performRequestFromURL() {
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
    
    func test_getFromURL_deliversData() {
        URLProtocol.registerClass(MockSession.self)
       
        let sut = URLSessionHTTPClient()
        let anyURL = URL(string: "https://www.any-url.com")!
        let waitForRequest = expectation(description: "wait for async call")
        let anyData = Data()
        MockSession.stub(data: anyData)
        
        sut.get(from: anyURL, completion: { data in
            XCTAssertEqual(anyData, data)
            waitForRequest.fulfill()
        })
        
        wait(for: [waitForRequest], timeout: 1.0)
        URLProtocol.unregisterClass(MockSession.self)
    }
}

private class MockSession: URLProtocol {
    
    static var listenToRequest: ((URLRequest) -> Void)? = nil
    private static var stub: Stub? = nil
    
    private struct Stub {
        let data: Data
    }
    
    static func stub(data: Data) {
        stub = Stub(data: data)
    }

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
        
        if let stub = MockSession.stub {
            client?.urlProtocol(self, didLoad: stub.data)
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() { }
}
