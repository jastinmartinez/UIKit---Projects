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
    
    func test_loadCatActions_requestCatsFromLoader() {
        let (sut, loader) = makeSUT()
        XCTAssertEqual(loader.localCallCount, 0)
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(loader.localCallCount, 1)
        
        sut.simulatePullToRefresh()
        XCTAssertEqual(loader.localCallCount, 2)
        
        sut.simulatePullToRefresh()
        XCTAssertEqual(loader.localCallCount, 3)
    }
    
    func test_loadingCatIndicator_isVisibleWhileLoadingCats() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        sut.simulateLoadingIndicator()
        XCTAssertTrue(sut.isShowingLoadingIndicator)
        
        loader.complete()
        XCTAssertFalse(sut.isShowingLoadingIndicator)
        
        sut.simulateUserInitiatedCatReload()
        XCTAssertTrue(sut.isShowingLoadingIndicator)
        
        loader.complete(at: 1)
        XCTAssertFalse(sut.isShowingLoadingIndicator)
        
        sut.simulateUserInitiatedCatReload()
        XCTAssertTrue(sut.isShowingLoadingIndicator)
        
        loader.complete(with: anyError())
        XCTAssertFalse(sut.isShowingLoadingIndicator)
    }
    
    func test_loadCatCompletion_rendersSuccessfullyLoaderCat() {
        let cat0 = makeCat(size: 1, tags: ["Cute", "Ugly"])
        let cat1 = makeCat(size: 1, tags: ["Cute", "Ugly", "Dummy"])
        let cat2 = makeCat(size: 1, tags: ["Cute"])
        
        let (sut, loader) = makeSUT()
        sut.loadViewIfNeeded()
        assertThat(sut, isRendering: [])
        
        loader.complete(with: [cat0], at: 0)
        assertThat(sut, isRendering: [cat0])
        
        sut.simulateUserInitiatedCatReload()
        let cats = [cat0, cat1, cat2]
        loader.complete(with: cats, at: 1)
        assertThat(sut, isRendering: cats)
    }
    
    func test_loadCatCompletion_doesNotAlterCurrentRenderingStateOnError() {
        let cat = makeCat()
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        loader.complete(with: [cat])
        assertThat(sut, isRendering: [cat])
        
        sut.simulateUserInitiatedCatReload()
        loader.complete(with: anyError())
        assertThat(sut, isRendering: [cat])
    }
    
    func test_catView_loadsImageURLWhenVisible() {
        let cat0 = makeCat()
        let cat1 = makeCat()
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        loader.complete(with: [cat0, cat1])
        XCTAssertEqual(loader.loadedImageIds, [], "Expected no image URL requests until views become visible")
        
        sut.simulateCatViewVisible()
        XCTAssertEqual(loader.loadedImageIds, [cat0.id])
    }
    
    func test_catView_cancelImageURLWhenNotVisible() {
        let cat0 = makeCat()
        let cat1 = makeCat()
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        loader.complete(with: [cat0, cat1])
        XCTAssertEqual(loader.loadedImageIds, [], "Expected no image URL requests until views become visible")
        
        sut.simulateCatViewNotVisible(at: 0)
        XCTAssertEqual(loader.cancelImageIds, [cat0.id], "Expected to be cancel since cell is not visible")
        
        sut.simulateCatViewNotVisible(at: 1)
        XCTAssertEqual(loader.cancelImageIds, [cat0.id, cat1.id], "Expected both to be cancel since cell is not visible")
    }
    
    private func makeSUT(  file: StaticString = #filePath,
                           line: UInt = #line) -> (CatsViewController, CatLoaderSpy) {
        let catLoader = CatLoaderSpy()
        let sut = CatsViewController(catLoader: catLoader,
                                     imageLoaderAdapter: catLoader)
        trackMemoryLeaks(instance: catLoader, file: file, line: line)
        trackMemoryLeaks(instance: sut, file: file, line: line)
        return (sut, catLoader)
    }
    
    private func makeCat(size: Int = 1, tags: [String] = ["Dumb"]) -> Cat {
        return Cat(id: UUID().uuidString, size: size, tags: tags)
    }
    
    private func assertThat(_ sut: CatsViewController,
                            isRendering cats: [Cat],
                            file: StaticString = #file,
                            line: UInt = #line) {
        guard sut.numberOfRenderedCatViews() == cats.count else {
            return XCTFail("Expected \(cats.count) cats, got \(sut.numberOfRenderedCatViews()) instead.", file: file, line: line)
        }
        
        cats.enumerated().forEach { index, image in
            assertThat(sut, hasViewConfiguredFor: image, at: index, file: file, line: line)
        }
    }
    
    private func assertThat(_ sut: CatsViewController,
                            hasViewConfiguredFor cat: Cat,
                            at index: Int,
                            file: StaticString = #file,
                            line: UInt = #line) {
        let view = sut.catView(at: index)
        
        guard let cell = view as? CatTableViewCell else {
            return XCTFail("Expected \(CatTableViewCell.self) instance, got \(String(describing: view)) instead", file: file, line: line)
        }
        XCTAssertEqual(cell.tags, cat.tags, file: file, line: line)
    }
}

class CatLoaderSpy: CatLoader, ImageLoaderAdapter {
   
    //    MARK: ImageLoaderAdapter
    
    private var catImageLoaderMessages = [(id: String, completion: (CatApp.ImageLoaderResult) -> Void)]()
    private var cancelCatImageLoaderMessages = [String]()
    
    var loadedImageIds: [String] {
        return catImageLoaderMessages.map({$0.id})
    }
    
    var cancelImageIds: [String] {
        return cancelCatImageLoaderMessages
    }
    
    func load(from id: String, completion: @escaping (CatApp.ImageLoaderResult) -> Void) -> ImageLoaderTask {
        catImageLoaderMessages.append((id, completion))
        return CancelTasks {  [weak self]in
            self?.cancelCatImageLoaderMessages.append(id)
        }
    }

    private struct CancelTasks: ImageLoaderTask {
        let callBack: () -> Void
        func cancel() {
            callBack()
        }
    }

    //    MARK: CatLoader
    
    private var catLoaderMessages = [(CatApp.CatLoaderResult) -> Void]()
    
    var localCallCount: Int {
        return catLoaderMessages.count
    }
    
    func load(completion: @escaping (CatApp.CatLoaderResult) -> Void) {
        catLoaderMessages.append(completion)
    }
    
    func complete(with cats: [Cat] = [], at index: Int = 0) {
        catLoaderMessages[index](.success(cats))
    }
    
    func complete(with error: Error, at index: Int = 0) {
        catLoaderMessages[index](.failure(error))
    }
}

private extension CatsViewController {
    
    func catView(at row: Int) -> UITableViewCell? {
        let ds = tableView.dataSource
        let index = IndexPath(row: row, section: catSection)
        return ds?.tableView(tableView, cellForRowAt: index)
    }
    
    @discardableResult
    func simulateCatViewVisible(at index: Int = 0) -> CatTableViewCell? {
        return catView(at: index) as? CatTableViewCell
    }
    
    func simulateCatViewNotVisible(at index: Int = 0) {
        let view = catView(at: index)
        let delegate = tableView.delegate
        let indexPath = IndexPath(row: index, section: catSection)
        delegate?.tableView?(tableView, didEndDisplaying: view!, forRowAt: indexPath)
    }
    
    private var catSection: Int {
        return 0
    }
    
    func numberOfRenderedCatViews() -> Int {
        return tableView.numberOfRows(inSection: catSection)
    }
    
    func simulatePullToRefresh() {
        refreshControl?.simulatePullToRefresh()
    }
    
    func simulateUserInitiatedCatReload() {
        simulatePullToRefresh()
        mockViewIsLoadingTransition()
    }
    
    func simulateLoadingIndicator() {
        replaceRefreshControllerWithFake()
        mockViewIsLoadingTransition()
    }
    
    var isShowingLoadingIndicator: Bool {
        return self.refreshControl?.isRefreshing == true
    }
    
    private func mockViewIsLoadingTransition() {
        beginAppearanceTransition(true, animated: false)
        endAppearanceTransition()
    }
    
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


private extension CatTableViewCell {
    var tags: [String] {
        return tagComponents.compactMap({ $0.label.text })
    }
}
