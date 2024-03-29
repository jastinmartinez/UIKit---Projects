//
//  RemoteImageLoader.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import Foundation

final public class RemoteImageLoader: ImageLoader {
   
    private let client: HTTPClient
    private let catImageQueue = DispatchQueue(label: "com.catImage.download",
                                              qos: .userInteractive,
                                              attributes: .concurrent)
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func load(from url: URL, completion: @escaping (ImageLoaderResult) -> Void) {
        catImageQueue.async { [client] in
            client.get(from: url) { clientResult in
                switch clientResult {
                case .success(let data, let response):
                    completion(RemoteImageLoader.map(data: data, response: response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    private static func map(data: Data, response: HTTPURLResponse) -> ImageLoaderResult {
        guard response.statusCode == RemoteImageLoader.OK_200 else {
            return .failure(Error.statusCode)
        }
        return .success(data)
    }
}

extension RemoteImageLoader {
    public enum Error: Swift.Error {
        case statusCode
    }
    
    private static var OK_200: Int {
        return RemoteStatusCodes.OK.rawValue
    }
}
