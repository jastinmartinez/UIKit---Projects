//
//  ShowViewModelTests.swift
//  TVShowAppTests
//
//  Created by Jastin on 27/11/23.
//

import Foundation
import XCTest
import TVShowApp
import DomainLayer
import PresentationLayer

public final class ShowViewModelTests: XCTestCase {
    
    func test_canInit_requiredParameters() {
        let showInteractorMock = ShowInteractorMock()
        let externalImageInteractorMock = ExternalImageInteractorMock()
        let sut = ShowViewModel(showInteractorProtocol: showInteractorMock, externalImageInteractorProtocol: externalImageInteractorMock)
    }
    
    func test_whenFetchShows_PassParameter() {
        let root = makeSUT()
        let expectParameter = ["page": 1]
        
        root.sut.fetchShows()
        
        XCTAssertEqual(root.show.parameter, expectParameter)
    }
    
    private func makeSUT() -> SUT {
        let showInteractorMock = ShowInteractorMock()
        let externalImageInteractorMock = ExternalImageInteractorMock()
        let sut = ShowViewModel(showInteractorProtocol: showInteractorMock, externalImageInteractorProtocol: externalImageInteractorMock)
        return SUT(sut: sut, show: showInteractorMock)
    }
    
    private struct SUT {
        let sut: ShowViewModel
        let show: ShowInteractorMock
    }
}

private class ShowInteractorMock: ShowInteractorProtocol {
    var parameter = [String: Int]()
    func fetchShowList(queryParameter: Dictionary<String, Int>, handler: @escaping ((Result<[DomainLayer.ShowEntity], DomainLayer.DomainError>) -> Void)) {
        parameter = queryParameter
    }
}

private class ExternalImageInteractorMock: ExternalImageInteractorProtocol {
    func fetchExternalImage(imageUrl: String, handler: @escaping ((Result<Data?, DomainLayer.DomainError>) -> Void)) {
        
    }
}
