//
//  CatItemImageLoaderAdapter.swift
//  CatApp
//
//  Created by Jastin on 13/4/24.
//

import Foundation

public final class CatItemImageLoaderAdapter: ImageLoaderAdapter {
    
    private let path: String
    private let imageLoader: ImageLoader
    
    public init(path: String, imageLoader: ImageLoader) {
        self.path = path
        self.imageLoader = imageLoader
    }
    
    public func load(from id: String, completion: @escaping (CatApp.ImageLoaderResult) -> Void) -> ImageLoaderTask {
        guard let url = URL(string: path + id) else {
            completion(.failure(Error.url))
            return CatImageLoaderTask()
        }
        imageLoader.load(from: url, completion: completion)
        return CatImageLoaderTask()
    }
    
    public enum Error: Swift.Error {
        case url
    }
}

struct CatImageLoaderTask: ImageLoaderTask {
    func cancel() {
        
    }
}
