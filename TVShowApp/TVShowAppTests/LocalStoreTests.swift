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
        
        expect(when: sut.get(for: key), expect: .success(true))
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
        
        expect(when: sut.get(for: key), expect: .success(false))
    }
    
    
    func test_localStore_deliversErrorWhetNotFound() {
        let (sut, key) = makeSUT()
        
        let result = sut.get(for: key)
        
        expect(when: result, expect: .failure(NSError(domain: "Key not Found", code: 0)))
    }
    
    private func makeSUT() -> (sut: LocalStorer, key: String) {
        let mock = MockStore()
        let key = "key"
        let sut = LocalStorer(localStore: mock)
        return (sut, key)
    }
    
    private func expect(when complete: Result<Bool, Error>,
                        expect value: Result<Bool, Error> ,
                        file: StaticString = #filePath,
                        line: UInt = #line) {
        switch(value, complete) {
        case let (.success(expectedSuccess), .success(actualSuccess)):
            XCTAssertEqual(expectedSuccess,
                           actualSuccess,
                           file: file,
                           line: line)
        case let (.failure(expectedFailure), .failure(actualFailure)):
            XCTAssertEqual(expectedFailure.localizedDescription,
                           actualFailure.localizedDescription,
                           file: file,
                           line: line)
        default:
            XCTFail("not match expected")
        }
    }
}

final private class MockStore: LocalStore {
    
    private var dic = [String: Bool]()
    
    func get(for key: String) -> Result<Bool, Error> {
        if let value = dic[key] {
            return .success(value)
        } else {
            return .failure(NSError(domain: "Key not Found", code: 0))
        }
    }
    
    func save(for key: String, with value: Bool) {
        dic[key] = value
    }
    
    func count() -> Int {
        return dic.count
    }
}

