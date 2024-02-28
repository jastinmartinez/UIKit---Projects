//
//  RemoteImageLoaderTests.swift
//  CatAppTests
//
//  Created by Jastin on 27/2/24.
//

import Foundation
import XCTest
import CatApp


final class RemoteImageLoaderTests: XCTestCase {
    
    func test_load_performClientRequest() {
        let url = anyURL()
        let (sut, client) = makeSUT()
        
        sut.load(from: url, completion: {_ in })
        
        XCTAssertEqual(client.urls, [url])
    }
    
    func test_load_performClientRequest_DeliversError() {
        let (sut, client) = makeSUT()
        let url = anyURL()
        let error = anyError()
        
        expect(from: sut, with: url, complete: {
            client.completeWith(error: error)
        }, expect: .failure(error))
    }
    
    func test_load_performClientRequest_DeliversOn200HTTPResponseData() {
        let (sut, client) = makeSUT()
        let url = anyURL()
        let data = anyData()
        let anyResponse = anyResponse(from: url, statusCode: 200)
        
        expect(from: sut, with: url, complete: {
            client.completeWith(data: data, response: anyResponse)
        }, expect: .success(data))
    }
    
    func test_load_performClientRequest_DeliversErrorOn200HTTPResponseWithInvalidData() {
        let (sut, client) = makeSUT()
        let url = anyURL()
        let data = anyData()
        
        let anyResponse = anyResponse(from: url, statusCode: 500)
        
        expect(from: sut, with: url, complete: {
            client.completeWith(data: data, response: anyResponse)
        }, expect: .failure(RemoteImageLoader.Error.statusCode))
    }
    
    private func expect(from sut: RemoteImageLoader,
                        with url: URL,
                        complete: () -> Void,
                        expect: ImageLoaderResult,
                        file: StaticString = #filePath,
                        line: UInt = #line) {
        let exp = expectation(description: "wait for async call")
        
        sut.load(from: url, completion: { result in
           
            switch (expect, result) {
            case let (.success(expectData), .success(resultData)):
                XCTAssertEqual(expectData,
                               resultData,
                               file: file,
                               line: line)
                exp.fulfill()
            case let (.failure(expectError), .failure(resultError)):
                XCTAssertEqual(expectError.localizedDescription,
                               resultError.localizedDescription,
                               file: file,
                               line: line)
                exp.fulfill()
            default:
                XCTFail("Do not match all cases instead got \(result)",
                               file: file,
                               line: line)
            }
        })
        complete()
        wait(for: [exp], timeout: 1.0)
    }
    
    private func makeSUT() -> (RemoteImageLoader, MockHTTPClient) {
        let client = MockHTTPClient()
        let sut = RemoteImageLoader(client: client)
        return (sut, client)
    }
}
