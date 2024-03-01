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
        
        XCTAssertEqual(numbersOfRow(for: sut), 1)
        XCTAssertTrue(tableViewCell(for: sut, cell: CatLoadingTableViewCell.self), "Instance do not match")
    }
    
    func test_onViewDidLoad_catLoaderLoad_deliversData() {
        let (sut, client) = makeSUT()
        let cats = makeCats()
        
        sut.viewDidLoad()
        
        client.completeWith(cats: cats)
        
        XCTAssertEqual(String(describing: sut.catPresenter.catState), String(describing: DataStatePresenter<[Cat]>.success(cats)))
    }
    
    func test_onViewDidLoad_catLoaderLoad_deliversData_toCatTableView() {
        let (sut, client) = makeSUT()
        let cats = makeCats()
        
        sut.viewDidLoad()
        
        client.completeWith(cats: cats)
        
        XCTAssertEqual(String(describing: sut.catPresenter.catState), String(describing: DataStatePresenter<[Cat]>.success(cats)))
        XCTAssertEqual(numbersOfRow(for: sut), 3)
        XCTAssertTrue(tableViewCell(for: sut, cell: CatTableViewCell.self), "Instance do not match")
    }
    
    
    func test_onViewDidLoad_catLoaderLoad_deliversError() {
        let (sut, client) = makeSUT()
        let error = anyError()
        
        sut.viewDidLoad()
        
        client.completeWith(error: error)
        
        XCTAssertEqual(String(describing: sut.catPresenter.catState), String(describing: DataStatePresenter<[Cat]>.failure(error)))
        XCTAssertEqual(numbersOfRow(for: sut), 1)
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
                         line: UInt = #line) -> (CatsViewController, MockLoaderPresenter) {
        let client = MockLoaderPresenter()
        let sut = CatsViewController(catPresenter: client)
        sut.didSelectCat = didSelect
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

private class MockLoaderPresenter: CatLoaderPresenter {
   
    var catState: CatApp.DataStatePresenter<[Cat]> = .loading
    
    private var messages = [() -> Void]()
    
    func completeWith(cats: [Cat], at index: Int = 0) {
        catState = .success(cats)
        messages[index]()
    }
    
    func completeWith(error: Error, at index: Int = 0) {
        catState = .failure(error)
        messages[index]()
    }
    
    func getCats(completion: @escaping () -> Void) {
        catState = .loading
        messages.append(completion)
    }
    
    func getImage(from id: String, completion: @escaping (CatApp.DataStatePresenter<Data>) -> Void) { }
}
