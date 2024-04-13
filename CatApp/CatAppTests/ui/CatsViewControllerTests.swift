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
    
    func test_pullToRefresh_loadsCat() {
        let (sut, loader) = makeSUT()
        sut.loadViewIfNeeded()
        
        sut.refreshControl?.simulatePullToRefresh()
        XCTAssertEqual(loader.localCallCount, 2)
        
        sut.refreshControl?.simulatePullToRefresh()
        XCTAssertEqual(loader.localCallCount, 3)
    }
    
    func test_viewDidLoad_showsLoadingIndicator() {
        let (sut, _) = makeSUT()
        
        sut.loadViewIfNeeded()
        sut.replaceRefreshControllerWithFake()
        XCTAssertEqual(sut.refreshControl?.isRefreshing, false)
        
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertEqual(sut.refreshControl?.isRefreshing, true)

    }
    
    
    
    private func makeSUT(  file: StaticString = #filePath,
                           line: UInt = #line) -> (CatsViewController, CatLoaderSpy) {
        let catLoader = CatLoaderSpy()
        let sut = CatsViewController(catLoader: catLoader)
        trackMemoryLeaks(instance: catLoader, file: file, line: line)
        trackMemoryLeaks(instance: sut, file: file, line: line)
        return (sut, catLoader)
    }
    
    class CatLoaderSpy: CatLoader {
        
        var localCallCount: Int {
            return messages.count
        }
        
        private(set) var messages = [(CatApp.CatLoaderResult) -> Void]()
        
        func load(completion: @escaping (CatApp.CatLoaderResult) -> Void) {
            messages.append(completion)
        }
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
