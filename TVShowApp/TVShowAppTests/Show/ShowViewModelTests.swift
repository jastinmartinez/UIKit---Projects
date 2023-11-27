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
}

private class ShowInteractorMock: ShowInteractorProtocol {
    func fetchShowList(queryParameter: Dictionary<String, Any>, handler: @escaping ((Result<[DomainLayer.ShowEntity], DomainLayer.DomainError>) -> Void)) {
    }
}

private class ExternalImageInteractorMock: ExternalImageInteractorProtocol {
    func fetchExternalImage(imageUrl: String, handler: @escaping ((Result<Data?, DomainLayer.DomainError>) -> Void)) {
        
    }
}
