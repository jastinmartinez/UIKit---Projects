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
    
    public func load(from id: String, completion: @escaping (ImageLoader.Result) -> Void) -> ImageLoaderTask {
        let cancellable = CatItemImageLoaderAdapterCancelable(imageLoader: imageLoader)
        guard let url = URL(string: path + id) else {
            completion(.failure(Error.url))
            return cancellable
        }
        imageLoader.load(from: url, completion: completion)
        return cancellable
    }
    
    public enum Error: Swift.Error {
        case url
    }
}

struct CatItemImageLoaderAdapterCancelable: ImageLoaderTask {
    private let imageLoader: ImageLoader
    
    init(imageLoader: ImageLoader) {
        self.imageLoader = imageLoader
    }
    
    func cancel() {
        imageLoader.cancel()
    }
}

