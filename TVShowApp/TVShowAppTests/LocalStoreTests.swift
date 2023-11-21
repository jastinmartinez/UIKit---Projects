//
//  LocalStoreTests.swift
//  TVShowAppTests
//
//  Created by Jastin Martínez on 20/11/23.
//

import XCTest
import TVShowApp

final class LocalStoreTests: XCTestCase {
    
    func test_localStore_saveAValue() {
        let (sut, key) = makeSUT()
        
        sut.save(for: "key", with: true)
        
        expect(when: sut.get(for: key), expect: true)
    }
    
    func test_localStore_DoNotDuplicateWhenSaving() {
        let (sut, key) = makeSUT()
        
        sut.save(for: key, with: true)
        sut.save(for: key, with: true)
        
        XCTAssertEqual(1, sut.count)
    }
    
    func test_localStore_ReplaceWithLatestValue() {
        let (sut, key) = makeSUT()
        
        sut.save(for: key, with: true)
        sut.save(for: key, with: false)
        
        expect(when: sut.get(for: key), expect: false)
    }
    
    
    func test_localStore_deliversErrorWhetNotFound() {
        let (sut, key) = makeSUT()
        
        let result = sut.get(for: key)
        
        expect(when: result, expect: false)
    }
    
    private func makeSUT() -> (sut: LocalStorer, key: String) {
        let mock = MockStore()
        let key = "key"
        let sut = LocalStorer(localStore: mock)
        return (sut, key)
    }
    
    private func expect(when complete: Bool,
                        expect value: Bool ,
                        file: StaticString = #filePath,
                        line: UInt = #line) {
        XCTAssertEqual(value,
                       complete,
                       file: file,
                       line: line)
    }
}

final private class MockStore: LocalStore {
    
    private var dic = [String: Bool]()
    
    func get(for key: String) -> Bool {
        if let value = dic[key] {
            return value
        } else {
            return false
        }
    }
    
    func save(for key: String, with value: Bool) {
        dic[key] = value
    }
    
    func count() -> Int {
        return dic.count
    }
}
