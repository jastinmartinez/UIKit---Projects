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
    
    override func setUp() {
        super.setUp()
        URLProtocol.registerClass(MockSession.self)
    }
    
    override func tearDown() {
        super.tearDown()
        URLProtocol.unregisterClass(MockSession.self)
    }
    
    func test_getFromURL_performRequestFromURL() {
        let sut = URLSessionHTTPClient()
        let anyURL = anyURL()
        
        sut.get(from: anyURL)
        
        let waitForRequest = expectation(description: "wait for async call")
        MockSession.listenToRequest = { requestToReceived in
            XCTAssertEqual(anyURL, requestToReceived.url)
            waitForRequest.fulfill()
        }
        wait(for: [waitForRequest], timeout: 1.0)
    }
    
    func test_getFromURL_deliversData() {
        
        let sut = URLSessionHTTPClient()
        let anyURL = anyURL()
        let anyData = anyData()
        
        MockSession.stub(data: anyData)
        let waitForRequest = expectation(description: "wait for async call")
        sut.get(from: anyURL, completion: { data in
            XCTAssertEqual(anyData, data)
            waitForRequest.fulfill()
        })
        
        wait(for: [waitForRequest], timeout: 1.0)
    }
    
    private func makeSUT() -> URLSessionHTTPClient {
        let sut = URLSessionHTTPClient()
        return sut
    }
    
    private func anyData() -> Data {
        return Data()
    }
    
    private func anyURL() -> URL {
        return URL(string: "https://www.any-url.com")!
    }
    
    private func anyError() -> Error {
        return NSError(domain: "any error", code: 0)
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
