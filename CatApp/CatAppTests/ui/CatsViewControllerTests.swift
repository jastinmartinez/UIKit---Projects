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
    
    func test_onViewDidLoad_delegatesAreSet() {
        let (sut, _) = makeSUT()
        
        sut.viewDidLoad()
        
        XCTAssertTrue(isDataSourceSet(for: sut))
        XCTAssertTrue(isDelegateSet(for: sut))
    }
    
    func test_onViewDidLoad_isCatLoadingTableViewCellState() {
        let (sut, _) = makeSUT()
        
        sut.viewDidLoad()
       
        XCTAssertTrue(tableViewCell(for: sut, cell: CatLoadingTableViewCell.self), "Instance do not match")
    }
    
    func test_onViewDidLoad_catLoaderLoad_deliversData() {
        let (sut, client) = makeSUT()
        let cats = makeCats()
        
        sut.viewDidLoad()
        
        client.completeWith(cats: cats)
        
        XCTAssertEqual(sut.catPresenter.cats.count, 3)
        XCTAssertEqual(sut.catPresenter.cats.map({$0.id}), cats.map({$0.id}))
    }
    
    func test_onViewDidLoad_catLoaderLoad_deliversData_toCatTableView() {
        let (sut, client) = makeSUT()
        let cats = makeCats()
        
        sut.viewDidLoad()
        
        client.completeWith(cats: cats)
        
        XCTAssertEqual(sut.catPresenter.cats.map({$0.id}), cats.map({$0.id}))
        XCTAssertEqual(numbersOfRow(for: sut), 3)
        XCTAssertTrue(tableViewCell(for: sut, cell: CatTableViewCell.self), "Instance do not match")
    }
    
    
    func test_onViewDidLoad_catLoaderLoad_deliversError() {
        let (sut, client) = makeSUT()
        let error = anyError()
        
        sut.viewDidLoad()
        
        client.completeWith(error: error)
        
        XCTAssertTrue(sut.catPresenter.cats.isEmpty)
        XCTAssertEqual(numbersOfRow(for: sut), 0)
        XCTAssertTrue(tableViewCell(for: sut, cell: CatErrorTableViewCell.self), "Instance do not match")
    }
    
    func test_catsTableView_canSelectCatTableViewCell() {
        let select: (Int) -> Void = { index in
            XCTAssertEqual(index, 0)
        }
        let (sut, client) = makeSUT(didSelect: select)
        sut.viewDidLoad()
        let cats = makeCats()
        client.completeWith(cats: cats)
        didSelect(for: sut, at: 0)
    }
    
    //MARK:  HELPERS
    
    private func makeSUT(didSelect: @escaping (Int) -> Void = { _ in},
                         file: StaticString = #filePath,
                         line: UInt = #line) -> (CatsViewController, MockLoader) {
        let client = MockLoader()
        let sut = CatsViewController(catPresenter: client, didSelectCat: didSelect)
        trackMemoryLeaks(instance: sut, file: file, line: line)
        return (sut, client)
    }
    
    private func didSelect(for sut: CatsViewController, at index: Int) {
        sut.tableView(sut.catTableView, didSelectRowAt: IndexPath(row: index, section: 0))
    }
    
    private func tableViewCell(for sut: CatsViewController, cell: UITableViewCell.Type) -> Bool  {
        return type(of: sut.tableView(sut.catTableView, cellForRowAt: IndexPath(row: 0, section: 0))) == cell
    }
    
    private func isDataSourceSet(for sut: CatsViewController) -> Bool {
        return sut.catTableView.dataSource != nil
    }
    
    private func isDelegateSet(for sut: CatsViewController) -> Bool {
        return sut.catTableView.delegate != nil
    }
    
    private func numbersOfRow(for sut: CatsViewController, section: Int = 0) -> Int {
        return sut.catTableView.numberOfRows(inSection: section)
    }
}

private class MockLoader: CatPresenter {
   
    var state: CatApp.CatPresenterState = .loading
    
    private var messages = [() -> Void]()
    
    var cats: [Cat] = []
    
    func completeWith(cats: [Cat], at index: Int = 0) {
        self.cats = cats
        state = .success
        messages[index]()
    }
    
    func completeWith(error: Error, at index: Int = 0) {
        state = .failure(error)
        messages[index]()
    }
    
    func load(completion: @escaping () -> Void) {
        state = .loading
        messages.append(completion)
    }
}
