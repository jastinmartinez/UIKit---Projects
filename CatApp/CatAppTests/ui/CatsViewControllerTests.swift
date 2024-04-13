//
//  CatsViewControllerTests.swift
//  CatAppTests
//
//  Created by Jastin on 28/2/24.
//

import Foundation
import XCTest
import CatApp


final class CatsViewControllerTests: XCTestCase {
    
    func test_initDoesNotLoadCat() {
        let (sut, loader) = makeSUT()
        
        XCTAssertEqual(loader.localCallCount, 0)
    }
    
    func test_viewDidLoad_loadsCat() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(loader.localCallCount, 1)
    }
    
    func test_userInitiatedCatReload_loadsCat() {
        let (sut, loader) = makeSUT()
        sut.loadViewIfNeeded()
        
        sut.simulatePullToRefresh()
        XCTAssertEqual(loader.localCallCount, 2)
        
        sut.simulatePullToRefresh()
        XCTAssertEqual(loader.localCallCount, 3)
    }
    
    func test_viewDidLoad_showsLoadingIndicator() {
        let (sut, _) = makeSUT()
        
        sut.loadViewIfNeeded()
        sut.replaceRefreshControllerWithFake()
        XCTAssertEqual(sut.isShowingLoadingIndicator, false)
        
        sut.simulateLoadingIndicator()
        XCTAssertEqual(sut.isShowingLoadingIndicator, true)
    }
    
    func test_viewDidLoad_hidesLoadingIndicatorOnLoadCompletion() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        sut.simulateLoadingIndicator()
        loader.completeFeedLoading()
        
        XCTAssertEqual(sut.isShowingLoadingIndicator, false)
    }
    
    func test_userInitiatedCatReload_showsLoadingIndicator() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        sut.replaceRefreshControllerWithFake()
        sut.simulatePullToRefresh()
        sut.mockViewIsLoadingTransition()
        
        XCTAssertEqual(sut.isShowingLoadingIndicator, true)
    }
    
    func test_userInitiatedCatReload_hidesLoadingIndicatorOnLoaderCompletion() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        sut.replaceRefreshControllerWithFake()
        sut.simulatePullToRefresh()
        sut.mockViewIsLoadingTransition()
        
        loader.completeFeedLoading()
        XCTAssertEqual(sut.isShowingLoadingIndicator, false)
    }
    
    
    private func makeSUT(  file: StaticString = #filePath,
                           line: UInt = #line) -> (CatsViewController, CatLoaderSpy) {
        let catLoader = CatLoaderSpy()
        let sut = CatsViewController(catLoader: catLoader)
        trackMemoryLeaks(instance: catLoader, file: file, line: line)
        trackMemoryLeaks(instance: sut, file: file, line: line)
        return (sut, catLoader)
    }
}

class CatLoaderSpy: CatLoader {
    
    var localCallCount: Int {
        return messages.count
    }
    
    private(set) var messages = [(CatApp.CatLoaderResult) -> Void]()
    
    func load(completion: @escaping (CatApp.CatLoaderResult) -> Void) {
        messages.append(completion)
    }
    
    func completeFeedLoading() {
        messages[0](.success([]))
    }
}

private extension CatsViewController {
    func replaceRefreshControllerWithFake() {
        let fake = FakeUIRefreshController()
        refreshControl?.allTargets.forEach({ target in
            refreshControl?.actions(forTarget: target, forControlEvent: .valueChanged)?.forEach({ action in
                fake.addTarget(target, action: Selector(action), for: .valueChanged)
            })
        })
        refreshControl = fake
    }
    
    func simulatePullToRefresh() {
        refreshControl?.simulatePullToRefresh()
    }
    
    func simulateLoadingIndicator() {
        replaceRefreshControllerWithFake()
        mockViewIsLoadingTransition()
    }
    
    var isShowingLoadingIndicator: Bool {
        return self.refreshControl?.isRefreshing == true
    }
    
    func mockViewIsLoadingTransition() {
        beginAppearanceTransition(true, animated: false)
        endAppearanceTransition()
    }
}

private class FakeUIRefreshController: UIRefreshControl {
    private var _isRefreshing = false
    
    override var isRefreshing: Bool { _isRefreshing }
    
    override func beginRefreshing() {
        _isRefreshing = true
    }
    
    override func endRefreshing() {
        _isRefreshing = false
    }
}

private extension UIRefreshControl {
    func simulatePullToRefresh() {
        allTargets.forEach({ target in
            actions(forTarget: target, forControlEvent: .valueChanged)?.forEach({
                (target as NSObject).perform(Selector($0))
            })
        })
    }
}
