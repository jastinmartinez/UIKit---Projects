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
        let (sut, _) = makeSUT(make([.loading]))
        
        sut.load()
    }
    
    func test_load_deliversLoadingThenSuccessState() {
        let state = make([.loading, .success])
        let (sut, client) = makeSUT(state)
        
        sut.load()
        
        client.completeWith(cats: [])
    }
    
    func test_load_deliversLoadingThenErrorState() {
        let error = anyError()
        let state = make([.loading, .failure(error)])
        let (sut, client) = makeSUT(state)
        
        sut.load()
        
        client.completeWith(error: error)
    }
    
    func test_load_deliversLoading_thenSuccessState_thenMapCats() {
        let state = make([.loading, .success])
        let (sut, client) = makeSUT(state)
        
        sut.load()
        client.completeWith(cats: makeCats())
        
        XCTAssertEqual(sut.cats.count, 3)
    }
    
    private func make(_ executionOrder: [CatPresenterState],
                      file: StaticString = #filePath,
                      line: UInt = #line) -> (CatPresenterState) -> Void {
        var execution = 0
        let catPresenterState: (CatPresenterState) -> Void = {
            XCTAssertEqual(String(describing: $0),
                           String(describing: executionOrder[execution]),
                           file: file,
                           line: line)
            execution += 1
        }
        return catPresenterState
    }
    
    private func makeSUT(_ state: @escaping (CatPresenterState) -> Void) -> (CatViewModel, MockCatLoader) {
        let client = MockCatLoader()
        let sut = CatViewModel(catLoader: client, state: state)
        trackMemoryLeaks(instance: sut)
        return (sut, client)
    }
}
