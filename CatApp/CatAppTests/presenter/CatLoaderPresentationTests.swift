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
        let (sut, _) = makeSUT()
        
        sut.getCats(completion: { })
        XCTAssertEqual(String(describing: sut.catState),
                       String(describing: DataStatePresenter<[Cat]>.loading))
    }
    
    func test_getCats_deliversLoadingThenSuccessState() {
        let (sut, client) = makeSUT()
        
        sut.getCats(completion: { })
        XCTAssertEqual(String(describing: sut.catState),
                       String(describing: DataStatePresenter<[Cat]>.loading))
        client.completeWith(cats: [])
        XCTAssertEqual(String(describing: sut.catState),
                       String(describing: DataStatePresenter<[Cat]>.success([])))
    }
    
    func test_getCats_deliversLoadingThenErrorState() {
        let error = anyError()
        let (sut, client) = makeSUT()
        
        sut.getCats(completion: { })
        XCTAssertEqual(String(describing: sut.catState),
                       String(describing: DataStatePresenter<[Cat]>.loading))
        client.completeWith(error: error)
        XCTAssertEqual(String(describing: sut.catState),
                       String(describing: DataStatePresenter<[Cat]>.failure(error)))
    }
    
    func test_getCats_deliversLoading_thenSuccessState_thenMapCats() {
        let (sut, client) = makeSUT()
        let cats = makeCats()
        sut.getCats(completion: { })
        XCTAssertEqual(String(describing: sut.catState),
                       String(describing: DataStatePresenter<[Cat]>.loading))
        client.completeWith(cats: makeCats())
        XCTAssertEqual(String(describing: sut.catState),
                       String(describing: DataStatePresenter<[Cat]>.success(cats)))
        
    }
    
    
    
    
    private func makeSUT() -> (CatLoaderPresentation, MockCatLoader) {
        let mockCatLoader = MockCatLoader()
        let mockCatItemImageLoader = MockCatItemImageLoader()
        let sut = CatLoaderPresentation(catLoader: mockCatLoader, catItemImageLoader: mockCatItemImageLoader)
        trackMemoryLeaks(instance: sut)
        return (sut, mockCatLoader)
    }
    
    private class MockCatItemImageLoader: CatItemImageLoader {
        
        private var messages = [(String, (CatApp.ImageLoaderResult) -> Void)]()
        
        func load(from id: String, completion: @escaping (CatApp.ImageLoaderResult) -> Void) {
            messages.append((id, completion))
        }
    }
}
