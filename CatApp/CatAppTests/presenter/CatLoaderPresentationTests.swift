//
//  CatLoaderPresentationTests.swift
//  CatAppTests
//
//  Created by Jastin on 28/2/24.
//

import Foundation
import XCTest
import CatApp


final class CatLoaderPresentationTests: XCTestCase {
    
    func test_getCats_deliversLoadingState() {
        let (sut, _, _) = makeSUT()
        
        sut.getCats(completion: { })
        XCTAssertEqual(String(describing: sut.catState),
                       String(describing: DataStatePresenter<[Cat]>.loading))
    }
    
    func test_getCats_deliversLoadingThenSuccessState() {
        let (sut, client, _) = makeSUT()
        
        sut.getCats(completion: { })
        XCTAssertEqual(String(describing: sut.catState),
                       String(describing: DataStatePresenter<[Cat]>.loading))
        client.completeWith(cats: [])
        XCTAssertEqual(String(describing: sut.catState),
                       String(describing: DataStatePresenter<[Cat]>.success([])))
    }
    
    func test_getCats_deliversLoadingThenErrorState() {
        let error = anyError()
        let (sut, client, _) = makeSUT()
        
        sut.getCats(completion: { })
        XCTAssertEqual(String(describing: sut.catState),
                       String(describing: DataStatePresenter<[Cat]>.loading))
        client.completeWith(error: error)
        XCTAssertEqual(String(describing: sut.catState),
                       String(describing: DataStatePresenter<[Cat]>.failure(error)))
    }
    
    func test_getCats_deliversLoading_thenSuccessState_thenMapCats() {
        let (sut, client, _) = makeSUT()
        let cats = makeCats()
        sut.getCats(completion: { })
        XCTAssertEqual(String(describing: sut.catState),
                       String(describing: DataStatePresenter<[Cat]>.loading))
        client.completeWith(cats: makeCats())
        XCTAssertEqual(String(describing: sut.catState),
                       String(describing: DataStatePresenter<[Cat]>.success(cats)))
        
    }
    
    func test_getImage_completeSuccessWithData() {
        let (sut, _, client) = makeSUT()
        let id = "imageId"
        let anyData = anyData()
        
        let exp = expectation(description: "wait for async code")
        sut.getImage(from: id, completion: { result in
            if case .success(let data) = result {
                XCTAssertEqual(data, anyData)
                exp.fulfill()
            }
        })
        client.completeWith(data: anyData)
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getImage_notifyIsLoading() {
        let (sut, _, _) = makeSUT()
        let id = "imageId"
        
        let exp = expectation(description: "wait for async code")
        sut.getImage(from: id, completion: { result in
            XCTAssertEqual(String(describing: result),
                           String(describing: DataStatePresenter<Data>.loading))
            exp.fulfill()
        })
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getImage_notifyIsLoading_thenDeliversData() {
        let (sut, _, client) = makeSUT()
        let id = "imageId"
        let anyData = anyData()
        
        let order = [DataStatePresenter<Data>.loading, DataStatePresenter<Data>.success(anyData)]
        var index = 0
        let exp = expectation(description: "wait for async code")
        exp.expectedFulfillmentCount = 2
      
        sut.getImage(from: id, completion: { result in
            XCTAssertEqual(String(describing: order[index]), String(describing: result))
            index += 1
            exp.fulfill()
        })
        client.completeWith(data: anyData)
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getImage_notifyIsLoading_thenDeliversError() {
        let (sut, _, client) = makeSUT()
        let id = "imageId"
        let error = anyError()
        
        let order = [DataStatePresenter<Data>.loading, DataStatePresenter<Data>.failure(error)]
        var index = 0
        let exp = expectation(description: "wait for async code")
        exp.expectedFulfillmentCount = 2
        
        sut.getImage(from: id, completion: { result in
            XCTAssertEqual(String(describing: order[index]), String(describing: result))
            index += 1
            exp.fulfill()
        })
        client.completeWith(error: error)
        wait(for: [exp], timeout: 1.0)
    }
    
    
    private func makeSUT() -> (CatLoaderPresentation, MockCatLoader, MockCatItemImageLoader) {
        let mockCatLoader = MockCatLoader()
        let mockCatItemImageLoader = MockCatItemImageLoader()
        let sut = CatLoaderPresentation(catLoader: mockCatLoader, catItemImageLoader: mockCatItemImageLoader)
        trackMemoryLeaks(instance: sut)
        return (sut, mockCatLoader, mockCatItemImageLoader)
    }
    
    
    private class MockCatItemImageLoader: CatItemImageLoader {
        
        private var messages = [(String, (CatApp.ImageLoaderResult) -> Void)]()
        
        func load(from id: String, completion: @escaping (CatApp.ImageLoaderResult) -> Void) {
            messages.append((id, completion))
        }
        
        func completeWith(data: Data, at index: Int = 0) {
            messages[index].1(.success(data))
        }
        
        func completeWith(error: Error, at index: Int = 0) {
            messages[index].1(.failure(error))
        }
    }
}
