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
        
        sut.save(for: key, with: true)
        
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
    
    private func makeSUT() -> (sut: LocalStorer, key: LocalStorer.Keys) {
        let mock = MockStore()
        let sut = LocalStorer(localStore: mock)
        return (sut, .biometric)
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
