//
//  TrackMemoryLeaks+XCTestCase.swift
//  CatAppTests
//
//  Created by Jastin on 28/2/24.
//

import Foundation
import XCTest

extension XCTestCase {
    func trackMemoryLeaks(instance: AnyObject,
                          file: StaticString = #filePath,
                          line: UInt = #line
    ) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance,
                         "Instance of object not deallocated possible memory leak",
                         file: file,
                         line: line)
        }
    }
}
