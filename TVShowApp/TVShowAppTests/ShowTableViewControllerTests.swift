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
    
    func test_whenInit_thenVcDontCrash() {
        let sut = makeSUT()
        
        sut.viewDidLoad()
        
        XCTAssertTrue(sut.isViewLoaded)
    }
    
    func test_whenInit_thenDataSourceAndDelegatesAreSet() {
        let sut = makeSUT()
        
        sut.viewDidLoad()
        
        XCTAssertNotNil(sut.isDataSourceSet())
        XCTAssertNotNil(sut.isDelegateSet())
    }
    
    func test_whenInit_thenIsInLoadingState() {
        let sut = makeSUT()
        
        sut.viewDidLoad()
        
        XCTAssertTrue(sut.fetchingActivityIndicator.isAnimating)
        XCTAssertEqual(1, sut.numberOfSections)
    }
    
    func test_whenDeliversData_thenComponentIsRendered() {
        let sut = makeSUT()
        
        sut.viewDidLoad()
        sut.showViewModel.showsState =  { [sut] state  in
            if case .loading = state {
                XCTAssertTrue(sut.fetchingActivityIndicator.isAnimating)
                XCTAssertEqual(3, sut.numberOfRows)
            }
        }
    }
    
    
    func test_whenDeliversError_thenShowError() {
        let sut = makeSUT()
        
        sut.viewDidLoad()
        sut.showViewModel.showsState =  { [sut] state in
            if case .done = state {
                XCTAssertFalse(sut.fetchingActivityIndicator.isAnimating)
                XCTAssertEqual(3, sut.numberOfRows)
            }
        }
    }
    
    
    private func makeSUT() -> ShowTableViewController {
        let showEpisodeInteractionStub = ShowEpisodeInteractionStub()
        let showInteractionStub = ShowInteractionStub()
        let externalImageInteractionStub = ExternalImageInteractionStub()
        
        let showViewModel = ShowViewModel(showInteractorProtocol: showInteractionStub,
                                          externalImageInteractorProtocol: externalImageInteractionStub)
        
        let showEpisodeViewModel = ShowEpisodeViewModel(showEpisodeInteractorProtocol: showEpisodeInteractionStub,
                                                        externalImageInteractorProtocol: externalImageInteractionStub)
        
        let sut = ShowTableViewController(showViewModel: showViewModel,
                                          showEpisodeViewModel: showEpisodeViewModel)
        return sut
    }
}


final class ShowInteractionStub: ShowInteractorProtocol {
    func fetchShowList(queryParameter: Dictionary<String, Any>, handler: @escaping ((Result<[DomainLayer.ShowEntity], DomainLayer.DomainError>) -> Void)) {
        return handler(.success(showEntities()))
    }
    
    private func showEntities() -> [ShowEntity] {
        return [showEntity(), showEntity(), showEntity()]
    }
    
    private func showEntity() -> ShowEntity {
        return ShowEntity(id: Int.random(in: 100...200),
                          name: "Kirby Buckets",
                          image:Optional(ShowImageEntity(original:"https://static.tvmaze.com/uploads/images/original_untouched/1/4600.jpg",
                                                         data: nil)),
                          schedule: ShowScheduleEntity(time: "07:00",
                                                       days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]),
                          genres: ["Comedy"],
                          summary: Optional("<p>The single-camera series that mixes live-action and animation stars Jacob Bertrand as the title character. <b>Kirby Buckets</b> introduces viewers to the vivid imagination of charismatic 13-year-old Kirby Buckets, who dreams of becoming a famous animator like his idol, Mac MacCallister. With his two best friends, Fish and Eli, by his side, Kirby navigates his eccentric town of Forest Hills where the trio usually find themselves trying to get out of a predicament before Kirby\'s sister, Dawn, and her best friend, Belinda, catch them. Along the way, Kirby is joined by his animated characters, each with their own vibrant personality that only he and viewers can see.</p>"),
                          rating: ShowRatingEntity(average: nil))
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



private extension ShowTableViewController {
    
    func isDataSourceSet() -> Bool {
        return showTableView.dataSource != nil
    }
    
    func isDelegateSet() -> Bool {
        return showTableView.dataSource != nil
    }
    
    var numberOfSections: Int {
        return showTableView.numberOfSections
    }
    
    var numberOfRows: Int {
        return showTableView.numberOfRows(inSection: 0)
    }
}
