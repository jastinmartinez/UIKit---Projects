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
    
    func test_whenInit_thenVcDoNotCrash() {
        let sut = makeSUT()
        
        sut.viewDidLoad()
        
        XCTAssertTrue(sut.isViewLoaded)
    }
    
    func test_whenInit_thenDataSourceAndDelegatesAreSet() {
        let sut = makeSUT()
        
        sut.viewDidLoad()
        
        XCTAssertTrue(sut.isDataSourceSet())
        XCTAssertTrue(sut.isDelegateSet())
    }
    
    func test_whenInit_thenIsInLoadingState() {
        let sut = makeSUT(.loading)
        
        sut.viewDidLoad()
        
        XCTAssertTrue(sut.isLoaderPresenting())
        XCTAssertEqual(sut.numberOfRows, 0)
    }
    
    func test_whenDeliversData_thenRenderComponent() {
        let sut = makeSUT(.done)
        
        sut.viewDidLoad()
        
        XCTAssertFalse(sut.isLoaderPresenting())
        XCTAssertEqual(sut.numberOfRows, 3)
    }
    
    
    func test_whenDeliversError_thenShowError() {
        let anyError = NSError(domain: "any error", code: 0)
        let sut = makeSUT(.fail(anyError))
        
        sut.viewDidLoad()
        
        XCTAssertFalse(sut.isLoaderPresenting())
        XCTAssertEqual(sut.numberOfRows, 0)
    }
    
    func test_whenThereIsShowsAndSelectTap_GoToDetailScreen() {
        let sut = makeSUT(.done)
        
        sut.viewDidLoad()
        sut.tap()
        setRunLoop()
        
        XCTAssertTrue(sut.navigationController?.topViewController is ShowDetailViewController)
    }
    
    func test_whenScrollAllToTheBottom_thenPerformFetchNextPageOfShows() {
        let sut = makeSUT(.done)
        
        sut.viewDidLoad()
        sut.scrollToBottom()
        
        XCTAssertEqual(sut.numberOfRows, 6)
    }
    
    private func makeSUT() -> (ShowTableViewController) {
        return makeSUT( .done)
    }
    
    private func makeSUT(_ state: PresentationLayer.ShowViewModel.ShowState) -> (ShowTableViewController) {
        let appComposer = buildAppComposer()
        let showViewModelStub = ShowViewModelStub(state: state)
        let sut = appComposer.getShowTableViewController(showViewModelActions: showViewModelStub)
        return sut.topViewController as! ShowTableViewController
    }
}


final class ShowViewModelStub: ShowViewModelActions {
    
    private let state: PresentationLayer.ShowViewModel.ShowState
    
    init(state: PresentationLayer.ShowViewModel.ShowState) {
        self.state = state
    }
    
    private var _showEntities = [DomainLayer.ShowEntity]()
    
    var showEntities: [DomainLayer.ShowEntity] {
        return _showEntities
    }
    
    var showsState: ((PresentationLayer.ShowViewModel.ShowState) -> Void)?
    
    func fetchShows() {
        if case .done = state {
            _showEntities = showEntitiesBuilder()
        }
        showsState?(state)
    }
    
    func fetchNextShows() {
        if case .done = state {
            _showEntities.append(contentsOf: showEntitiesBuilder())
        }
        showsState?(state)
    }
    
    private func showEntitiesBuilder() -> [ShowEntity] {
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

private extension ShowTableViewController {
    func isDataSourceSet() -> Bool {
        return showTableView.dataSource != nil
    }
    
    func isDelegateSet() -> Bool {
        return showTableView.delegate != nil
    }
    
    var numberOfSections: Int {
        return showTableView.numberOfSections
    }
    
    var numberOfRows: Int {
        return showTableView.numberOfRows(inSection: 0)
    }
    
    func isLoaderPresenting() -> Bool {
        return self.fetchingActivityIndicator.isAnimating
    }
    
    func tap(at index: Int = 0) {
        tableView(showTableView, didSelectRowAt: IndexPath(row: index, section: 0))
    }
    
    func scrollToBottom() {
        showTableView.contentOffset.y = 1000
        let anyScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        scrollViewDidEndDragging(anyScrollView, willDecelerate: true)
    }
}
