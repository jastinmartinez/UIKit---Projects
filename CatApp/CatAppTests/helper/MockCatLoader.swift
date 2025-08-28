//
//  MockCatLoader.swift
//  CatAppTests
//
//  Created by Jastin on 28/2/24.
//

import Foundation
import CatApp

final class MockCatLoader: CatLoader {
    
    private var messages = [(CatLoader.Result) -> Void]()
    
    func load(completion: @escaping (CatLoader.Result) -> Void) {
        messages.append(completion)
    }
    
    func completeWith(cats: [Cat], at index: Int = 0) {
        messages[index](.success(cats))
    }
    
    func completeWith(error: Error, at index: Int = 0) {
        messages[index](.failure(error))
    }
}
