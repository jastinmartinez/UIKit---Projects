//
//  URLSessionHTTPClient.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    
    private let session: URLSession
    private var task: URLSessionTask?
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    private struct UnExpectedError: Error { }
    
    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        self.task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse  {
                completion(.success(data, response))
            } else {
                completion(.failure(UnExpectedError()))
            }
        }
        task?.resume()
    }
    
    public func cancelRequest() {
        task?.cancel()
    }
}
