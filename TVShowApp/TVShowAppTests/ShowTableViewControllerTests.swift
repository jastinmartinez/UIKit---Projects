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
        let root = makeSUT(.done)
        
        root.sut.viewDidLoad()
        
        XCTAssertTrue(root.sut.isViewLoaded)
    }
    
    func test_whenInit_thenDataSourceAndDelegatesAreSet() {
        let root = makeSUT(.done)
        
        root.sut.viewDidLoad()
        
        XCTAssertTrue(root.sut.isDataSourceSet())
        XCTAssertTrue(root.sut.isDelegateSet())
    }
    
    func test_whenInit_thenIsInLoadingState() {
        let root = makeSUT(.loading)
        
        root.sut.viewDidLoad()
        
        XCTAssertTrue(root.sut.isLoaderPresenting())
        XCTAssertEqual(root.sut.numberOfRows, 0)
    }
    
    func test_whenDeliversData_thenRenderComponent() {
        let root = makeSUT(.done)
        
        root.sut.viewDidLoad()
        
        XCTAssertFalse(root.sut.isLoaderPresenting())
        XCTAssertEqual(root.sut.numberOfRows, 3)
    }
    
    
    func test_whenDeliversError_thenShowError() {
        let anyError = anyError()
        let root = makeSUT(.fail(anyError))
        
        root.sut.viewDidLoad()
        
        XCTAssertFalse(root.sut.isLoaderPresenting())
        XCTAssertEqual(root.sut.numberOfRows, 0)
    }
    
    func test_whenThereIsShowsAndSelectTap_GoToDetailScreen() {
        let root = makeSUT(.done)
        
        root.sut.viewDidLoad()
        root.sut.tap()
        RunLoop.current.run(until: .now)
        
        XCTAssertTrue(root.sut.navigationController?.topViewController is ShowDetailViewController)
    }
    
    func test_whenScrollAllToTheBottom_thenPerformFetchNextPageOfShowsDeliversData() {
        let root = makeSUT(.done)
        
        root.sut.viewDidLoad()
        root.sut.scrollToBottom()
        
        XCTAssertEqual(root.sut.numberOfRows, 6)
    }
    
    func test_whenScrollAllToTheBottom_thenPerformFetchNextPageOfShowsWaitForData() {
        let root = makeSUT(.done)
        
        root.sut.viewDidLoad()
        
        root.show.setState(for: .loading)
        root.sut.scrollToBottom()
        
        XCTAssertTrue(root.sut.isLoaderPresenting())
        XCTAssertEqual(root.sut.numberOfRows, 3)
    }
    
    func test_whenScrollAllToTheBottom_thenPerformFetchNextPageOfShowsDeliversError() {
        let root = makeSUT(.done)
        let anyError = anyError()
        
        root.sut.viewDidLoad()
        
        root.show.setState(for: .fail(anyError))
        root.sut.scrollToBottom()
        
        XCTAssertFalse(root.sut.isLoaderPresenting())
        XCTAssertEqual(root.sut.numberOfRows, 3)
    }
    
    func test_whenScrollAllToTheBottomTwice_thenPerformFetchNextPageOfShowsTwice() {
        let root = makeSUT(.done)
        
        root.sut.viewDidLoad()
        
        root.sut.scrollToBottom()
        root.sut.scrollToBottom()
        
        XCTAssertEqual(root.sut.numberOfRows, 9)
    }
    
    
    private func makeSUT(_ state: PresentationLayer.ShowViewModel.ShowState,
                         file: StaticString = #file,
                         line: UInt = #line) -> MakeSUT {
        
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let biometric = BiometricManager(localStorer: LocalStorer(localStore: MockStore()))
        let showViewModelStub =  ShowViewModelStub(state: state)
        let app = AppComposer(window: window,
                              biometricManager: biometric,
                              showViewModelActions: showViewModelStub)
        trackForMemoryLeaks(instance: app.showTableViewController, file: file, line: line)
        return MakeSUT(sut: app.showTableViewController,
                       show: showViewModelStub)
    }
    
    private struct MakeSUT {
        let sut: ShowTableViewController
        let show: ShowViewModelStub
    }
    
    private func anyError() -> Error {
        return NSError(domain: "any error", code: 0)
    }
    
    func trackForMemoryLeaks(instance: AnyObject,
                             file: StaticString = #file,
                             line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated, Potential memory leak.",
                         file: file,
                         line: line)
        }
    }
}

final class ShowViewModelStub: ShowViewModelActions {
    
    private var state: PresentationLayer.ShowViewModel.ShowState
    private var _showEntities = [DomainLayer.ShowEntity]()
    var showsState: ((PresentationLayer.ShowViewModel.ShowState) -> Void)?
    
    var showEntities: [DomainLayer.ShowEntity] {
        return _showEntities
    }
    
    init(state: PresentationLayer.ShowViewModel.ShowState) {
        self.state = state
    }
    
    func setState(for state: PresentationLayer.ShowViewModel.ShowState) {
        self.state = state
    }
    
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

private class MockNavigationController: UINavigationController {
    var pushCounter = 0
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushCounter += 1
    }
}
