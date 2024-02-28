//
//  RemoteCatLoader.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import Foundation

public final class RemoteCatLoader: CatLoader {
    
    private let url: URL
    private let client: HTTPClient
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (CatLoaderResult) -> Void) {
        self.client.get(from: url, completion: { clientResult in
            switch clientResult {
            case .success(let data, let response):
                completion(RemoteCatLoaderMapper.map(data, response: response))
            case .failure:
                completion(.failure(Error.api))
            }
        })
    }
}

extension RemoteCatLoader {
    public enum Error: Swift.Error {
        case api
        case statusCode(Int)
        case data(String)
    }
}
