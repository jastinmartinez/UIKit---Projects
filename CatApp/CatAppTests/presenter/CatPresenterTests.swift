//
//  CatPresenter.swift
//  CatAppTests
//
//  Created by Jastin on 28/2/24.
//

import Foundation
import XCTest
import CatApp


final class CatPresenterTests: XCTestCase {
    
    func test_load_deliversLoadingState() {
        let (sut, _) = makeSUT()
        
        sut.load(completion: { })
        XCTAssertEqual(String(describing: sut.state),
                       String(describing: CatPresenterState.loading))
    }
    
    func test_load_deliversLoadingThenSuccessState() {
        let (sut, client) = makeSUT()
        
        sut.load(completion: { })
        XCTAssertEqual(String(describing: sut.state),
                       String(describing: CatPresenterState.loading))
        client.completeWith(cats: [])
        XCTAssertEqual(String(describing: sut.state),
                       String(describing: CatPresenterState.success))
    }
    
    func test_load_deliversLoadingThenErrorState() {
        let error = anyError()
        let (sut, client) = makeSUT()
        
        sut.load(completion: { })
        XCTAssertEqual(String(describing: sut.state),
                       String(describing: CatPresenterState.loading))
        client.completeWith(error: error)
        XCTAssertEqual(String(describing: sut.state),
                       String(describing: CatPresenterState.failure(error)))
    }
    
    func test_load_deliversLoading_thenSuccessState_thenMapCats() {
        let (sut, client) = makeSUT()
        
        sut.load(completion: { })
        XCTAssertEqual(String(describing: sut.state),
                       String(describing: CatPresenterState.loading))
        client.completeWith(cats: makeCats())
        XCTAssertEqual(String(describing: sut.state),
                       String(describing: CatPresenterState.success))
        
        XCTAssertEqual(sut.cats.count, 3)
    }
    
    
    private func makeSUT() -> (CatViewModel, MockCatLoader) {
        let client = MockCatLoader()
        let sut = CatViewModel(catLoader: client)
        trackMemoryLeaks(instance: sut)
        return (sut, client)
    }
}
