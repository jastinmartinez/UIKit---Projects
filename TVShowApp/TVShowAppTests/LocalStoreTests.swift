//
//  LocalStoreTests.swift
//  TVShowAppTests
//
//  Created by Jastin Martínez on 20/11/23.
//

import XCTest
import TVShowApp

final class LocalStoreTests: XCTestCase {

    func test_localStore_storeAValue() {
        let sut = LocalStore()
        
        sut.save(for: "key", with: "value")
        
        XCTAssertEqual(sut.dic.count, 1)
    }
}

final class LocalStore {
    
    private(set) var dic = [String: String]()
    
    func save(for key: String, with value: String) {
        dic[key] = value
    }
}


