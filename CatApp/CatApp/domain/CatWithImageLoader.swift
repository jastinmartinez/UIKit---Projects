//
//  CatImageLoader.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import Foundation

public typealias CatImageLoader = CatLoader & ImageLoader

public final class CatWithImageLoader: CatImageLoader {
    
    private let catLoader: CatLoader
    private let imageLoader: ImageLoader
    
    public init(catLoader: CatLoader, imageLoader: ImageLoader) {
        self.catLoader = catLoader
        self.imageLoader = imageLoader
    }
    
    public func load(completion: @escaping (CatLoaderResult) -> Void) {
        catLoader.load(completion: completion)
    }
    
    public func load(from url: URL, completion: @escaping (ImageLoaderResult) -> Void) {
        imageLoader.load(from: url, completion: completion)
    }
}
