//
//  CatAppTests.swift
//  CatAppTests
//
//  Created by Jastin on 27/2/24.
//

import XCTest
import CatApp

final class URLSessionHTTPClientTests: XCTestCase {
    
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
    
    func test_getFromURL_deliversDataWithResponse() {
        
        let sut = URLSessionHTTPClient()
        let anyURL = anyURL()
        let anyData = anyData()
        let anyResponse = anyResponse(from: anyURL, statusCode: 200)
        
        MockSession.stub(data: anyData, urlResponse: anyResponse)
        let waitForRequest = expectation(description: "wait for async call")
        sut.get(from: anyURL, completion: { result in
            switch result {
            case .success(let data, let response):
                XCTAssertEqual(data, anyData)
                XCTAssertEqual(response.statusCode, anyResponse.statusCode)
                XCTAssertEqual(response.url, anyResponse.url)
            case .failure:
                XCTFail("Expected Success instead got \(result) ")
            }
            waitForRequest.fulfill()
        })
        
        wait(for: [waitForRequest], timeout: 1.0)
    }
    
    func test_getFromURL_deliversError() {
        let sut = URLSessionHTTPClient()
        let anyURL = anyURL()
        let anyError = anyError()
        
        MockSession.stub(error: anyError)
        let waitForRequest = expectation(description: "wait for async call")
        sut.get(from: anyURL, completion: { result in
            switch result {
            case .success:
                XCTFail("Expected failure instead got \(result) ")
            case .failure(let failure):
                XCTAssertEqual(anyError.localizedDescription, failure.localizedDescription)
            }
            waitForRequest.fulfill()
        })
        
        wait(for: [waitForRequest], timeout: 1.0)
    }
    
    
    func test_getFromURLPerformTwice_returnTwice() {
        let sut = URLSessionHTTPClient()
        let anyURL = anyURL()
        
        sut.get(from: anyURL)
        sut.get(from: anyURL)
        
        let waitForRequest = expectation(description: "wait for async call")
        
        waitForRequest.expectedFulfillmentCount = 2
        
        MockSession.listenToRequest = { requestToReceived in
            XCTAssertEqual(anyURL, requestToReceived.url)
            waitForRequest.fulfill()
        }
        wait(for: [waitForRequest], timeout: 1.0)
    }
    
    func test_getFromURL_deliversUnExpectError() {
        let sut = URLSessionHTTPClient()
        let anyURL = anyURL()
        MockSession.stub()
        
        let waitForRequest = expectation(description: "wait for async call")
        sut.get(from: anyURL, completion: { result in
            switch result {
            case .success:
                XCTFail("Expected failure instead got \(result) ")
            case .failure(let failure):
                XCTAssertTrue(!failure.localizedDescription.isEmpty)
            }
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
    
    private func anyResponse(from url: URL, statusCode: Int) -> HTTPURLResponse {
        return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: [:])!
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
        let data: Data?
        let error: Error?
        let urlResponse: URLResponse?
    }
    
    static func stub(data: Data? = nil,
                     error: Error? = nil,
                     urlResponse: URLResponse? = nil) {
        stub = Stub(data: data, error: error, urlResponse: urlResponse)
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
            return
        }
        
        if let data = MockSession.stub?.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let response = MockSession.stub?.urlResponse {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let error = MockSession.stub?.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}
