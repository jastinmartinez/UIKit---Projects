//
//  CatItemImageLoaderAdapter.swift
//  CatApp
//
//  Created by Jastin on 29/2/24.
//

import Foundation

public final class CatItemImageLoaderAdapter: CatItemImageLoader {
    
    private let path: String
    private let imageLoader: ImageLoader
    
    public init(path: String, imageLoader: ImageLoader) {
        self.path = path
        self.imageLoader = imageLoader
    }
    
    public func load(from id: String, completion: @escaping (CatApp.ImageLoaderResult) -> Void) {
        guard let url = URL(string: path + id) else {
            completion(.failure(Error.url))
            return
        }
        imageLoader.load(from: url, completion: completion)
    }
    
    public enum Error: Swift.Error {
        case url
    }
}
