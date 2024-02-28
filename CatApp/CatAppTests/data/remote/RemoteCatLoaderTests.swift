//
//  RemoteCatLoaderTests.swift
//  CatAppTests
//
//  Created by Jastin on 27/2/24.
//

import Foundation
import XCTest
import CatApp

final class RemoteCatLoaderTests: XCTestCase {
    
    func test_load_executeClient_getRequest() {
        let anyURL = anyURL()
        let (sut, client) = makeSUT(url: anyURL)
        
        sut.load(completion: { _ in })
        
        XCTAssertEqual([anyURL], client.urls)
    }
    
    func test_loadTwice_executeClient_getRequestTwice() {
        let anyURL = anyURL()
        let (sut, client) = makeSUT(url: anyURL)
        
        sut.load(completion: { _ in })
        sut.load(completion: { _ in })
        
        XCTAssertEqual([anyURL, anyURL], client.urls)
    }
    
    func test_load_executeClient_deliversError() {
        let (sut, client) = makeSUT()
        
        expect(from: sut, expect: .failure(.api))
    }
    
    func test_load_executeClient_deliversDataOn200HTTPResponse() {
        let anyURL = anyURL()
        let anyResponse = anyResponse(from: anyURL, statusCode: 200)
        let catData = Data(catString().utf8)
        let (sut, client) = makeSUT(url: anyURL, result: .success(catData, anyResponse))
        let cats = makeCats()
        
        expect(from: sut, expect: .success(cats))
    }
    
    func test_load_executeClient_deliversErrorOnNot200HTTPResponse() {
        let anyURL = anyURL()
        let anyData = anyData()
        
        let invalidCodeSamples = [201, 500, 400]
        
        for statusCode in invalidCodeSamples {
            let anyResponse = anyResponse(from: anyURL, statusCode: statusCode)
            let (sut, client) = makeSUT(url: anyURL, result: .success(anyData, anyResponse))
            expect(from: sut, expect: .failure(.statusCode(statusCode)))
        }
    }
    
    func test_load_executeClient_deliversErrorOn200HTTPResponseWithInvalidData() {
        let anyURL = anyURL()
        let anyData = anyData()
        let anyResponse = anyResponse(from: anyURL, statusCode: 200)
        let (sut, client) = makeSUT(url: anyURL, result: .success(anyData, anyResponse))
        
        expect(from: sut, expect: .failure(.data("")))
    }
    
    private func makeSUT(url: URL = anyURL(),
                         result: HTTPClientResult = .failure(anyError())) -> (RemoteCatLoader, MockHTTPClient) {
        let client = MockHTTPClient(result: result)
        let sut = RemoteCatLoader(url: url, client: client)
        return (sut, client)
    }
    
    private func expect(from sut: RemoteCatLoader,
                        expect: Result<[Cat],RemoteCatLoader.Error>,
                        file: StaticString = #filePath,
                        line: UInt = #line) {
        let exp = expectation(description: "wait for async call")
        
        sut.load(completion: { result in
            switch(expect, result) {
            case let (.success(expectData), .success(resultData)):
                XCTAssertEqual(expectData.map({$0.id}),
                               resultData.map({$0.id}),
                               file: file,
                               line: line)
            case let (.failure(expectError), .failure(resultError)):
                XCTAssertEqual(expectError.localizedDescription,
                               resultError.localizedDescription,
                               file: file,
                               line: line)
            default:
                XCTFail("Do not match any expectation instead got \(result)",
                        file: file,
                        line: line)
            }
            
            exp.fulfill()
        })
        wait(for: [exp], timeout: 1.0)
    }
    
    
    private func makeCats() -> [Cat] {
        return [Cat(id: "7RxMRzAMC39q879v",
                    size: 11728,
                    tags: ["cute"]),
                Cat(id: "vMacnX3oi0XtcTNB",
                    size: 19949,
                    tags: ["cute"]),
                Cat(id: "wINuKui2s7xdsBqV",
                    size: 17159,
                    tags: ["cute", "housemaid"])]
    }
    
    private func catString() ->String {
        return """
        [{"_id":"7RxMRzAMC39q879v","mimetype":"image/png","size":11728},
        {"_id":"vMacnX3oi0XtcTNB","mimetype":"image/jpeg","size":19949,"tags":["cute"]},
        {"_id":"wINuKui2s7xdsBqV","mimetype":"image/jpeg","size":17159,"tags":["cute","housemaid"]}]
        """
    }
}

private class MockHTTPClient: HTTPClient {
    
    private(set) var urls = [URL]()
    
    private let result: HTTPClientResult
    
    init(result: HTTPClientResult) {
        self.result = result
    }
    
    func get(from url: URL, completion: @escaping (CatApp.HTTPClientResult) -> Void) {
        urls.append(url)
        switch result {
        case .success(let data, let hTTPURLResponse):
            completion(.success(data, hTTPURLResponse))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
