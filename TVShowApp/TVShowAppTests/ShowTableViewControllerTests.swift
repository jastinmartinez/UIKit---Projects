//
//  ShowTableViewControllerTests.swift
//  TVShowAppTests
//
//  Created by Jastin on 21/11/23.
//

import XCTest
import PresentationLayer
import DomainLayer
import TVShowApp

final class ShowTableViewControllerTests: XCTestCase {
    
    func test_init_ViewController() {
        let showEpisodeInteractionStub = ShowEpisodeInteractionStub()
        let showInteractionStub = ShowInteractionStub()
        let externalImageInteractionStub = ExternalImageInteractionStub()
        
        let showViewModel = ShowViewModel(showInteractorProtocol: showInteractionStub,
                                          externalImageInteractorProtocol: externalImageInteractionStub)
        
        let showEpisodeViewModel = ShowEpisodeViewModel(showEpisodeInteractorProtocol: showEpisodeInteractionStub,
                                        externalImageInteractorProtocol: externalImageInteractionStub)
        
        let sut = ShowTableViewController(showViewModel: showViewModel,
                                          showEpisodeViewModel: showEpisodeViewModel)
        
        sut.viewDidLoad()
        
        XCTAssertTrue(sut.isViewLoaded)
     
    }
}


final class ShowInteractionStub: ShowInteractorProtocol {
    func fetchShowList(queryParemeter: Dictionary<String, Any>, handler: @escaping ((Result<[DomainLayer.ShowEntity], DomainLayer.DomainError>) -> Void)) {
        
    }
}

final class ExternalImageInteractionStub: ExternalImageInteractorProtocol {
    func fetchExternalImage(imageUrl: String, handler: @escaping ((Result<Data?, DomainLayer.DomainError>) -> Void)) {
        
    }
}

final class ShowEpisodeInteractionStub: ShowEpisodeInteractorProtocol {
    func fecthShowEpisodeList(showId: Int, handler: @escaping ((Result<[DomainLayer.ShowEpisodeEntity], DomainLayer.DomainError>) -> Void)) {
        
    }
}
