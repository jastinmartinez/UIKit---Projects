//
//  CatItemImageLoaderAdapterTests.swift
//  CatAppTests
//
//  Created by Jastin on 29/2/24.
//

import Foundation
import XCTest
import CatApp

final class CatItemImageLoaderAdapterTests: XCTestCase {
    
    func test_load_executeImageLoader_completesWithData() {
        let (sut, client) = makeSUT(path: "anyPath")
        let imageId = "anyID"
        let anyData = anyData()
        
        let exp = XCTestExpectation(description: "wait for async call")
        sut.load(from: imageId) { result in
            if case .success(let data) = result {
                XCTAssertEqual(data, anyData)
            }
            exp.fulfill()
        }
        client.completeWith(data: anyData)
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_load_executeImageLoader_completesWithErrorOnInvalidURL() {
        let (sut, _) = makeSUT(path: "")
        let imageID = ""
       
        let exp = XCTestExpectation(description: "wait for async call")
        sut.load(from: imageID) { result in
            if case .failure(let error) = result {
                XCTAssertEqual(String(describing: error), String(describing: CatItemImageLoaderAdapter.Error.url))
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_load_executeImageLoader_completesWithError() {
        let (sut, client) = makeSUT(path: "a")
        let imageID = "a"
        let anyError = anyError()
        
        let exp = XCTestExpectation(description: "wait for async call")
        sut.load(from: imageID) { result in
            if case .failure(let error) = result {
                XCTAssertEqual(error.localizedDescription, anyError.localizedDescription)
            }
            exp.fulfill()
        }
        client.completeWith(error: anyError)
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_load_executeImageLoader_deliversURLWithCorrectPath() {
        let path = "anyPath"
        let imageId = "anyId"
        let result = path + imageId
        let (sut, client) = makeSUT(path: path)
     
        
        sut.load(from: imageId) { result in }
       
        XCTAssertEqual(client.messages.map({$0.0.absoluteString}), [result])
    }
    
    func test_load_executeImageLoaderTwice_deliversURLTwice() {
        let path = "anyPath"
        let imageId = "anyId"
        let result = path + imageId
        let (sut, client) = makeSUT(path: path)
        
        sut.load(from: imageId) { result in }
        sut.load(from: imageId) { result in }
        
        XCTAssertEqual(client.messages.map({$0.0.absoluteString}), [result,result])
    }
    
    func test_load_canCancelRequest() {
        let path = "anyPath"
        let imageId = "anyId"
        let (sut, client) = makeSUT(path: path)
        
        let request = sut.load(from: imageId) { result in }
        request.cancel()
        
        XCTAssertEqual(client.cancelCounter, 1)
    }
    
    private func makeSUT(path: String) -> (CatItemImageLoaderAdapter, MockImageLoader) {
        let client = MockImageLoader()
        let sut = CatItemImageLoaderAdapter(path: path, imageLoader: client)
        trackMemoryLeaks(instance: sut)
        return (sut, client)
    }
}

private final class MockImageLoader: ImageLoader {
    
    var cancelCounter = 0
    private(set) var messages = [(URL, (ImageLoader.Result) -> Void)]()
    
   
    func load(from url: URL, completion: @escaping (ImageLoader.Result) -> Void) {
        messages.append((url, completion))
    }
    
    func completeWith(data: Data, at index: Int = 0) {
        messages[index].1(.success(data))
    }
    
    func completeWith(error: Error, at index: Int = 0) {
        messages[index].1(.failure(error))
    }
    
    func cancel() {
        cancelCounter += 1
    }
}
