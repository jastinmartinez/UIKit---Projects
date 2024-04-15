//
//  MockHTTPClient.swift
//  CatAppTests
//
//  Created by Jastin on 27/2/24.
//

import Foundation
import CatApp

class MockHTTPClient: HTTPClient {
    
    var cancelsCount = 0
    var concurrentQueueNotifier: (() -> Void)? = nil
    
    var urls: [URL] {
        return messages.map({ $0.url })
    }

    private var messages = [(url: URL, completion: (CatApp.HTTPClientResult) -> Void)]()
    
    func get(from url: URL, completion: @escaping (CatApp.HTTPClientResult) -> Void) {
        messages.append((url, completion))
        concurrentQueueNotifier?()
    }
    
    func completeWith(error: Error, at index: Int = 0) {
        messages[index].completion(.failure(error))
    }
    
    func completeWith(data: Data, response: HTTPURLResponse, at index: Int = 0) {
        messages[index].completion(.success(data, response))
    }
    
    func cancelRequest() {
        cancelsCount += 1
    }
}
