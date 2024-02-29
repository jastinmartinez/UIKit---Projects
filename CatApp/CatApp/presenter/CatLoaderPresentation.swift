//
//  CatViewModel.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import Foundation
import UIKit

public final class CatLoaderPresentation: CatLoaderPresenter {
    
    private let catLoader: CatLoader
    private let catItemImageLoader: CatItemImageLoader
    public var catState: DataStatePresenter<[Cat]>
    
    public init(catLoader: CatLoader, catItemImageLoader: CatItemImageLoader) {
        self.catLoader = catLoader
        self.catState = .loading
        self.catItemImageLoader = catItemImageLoader
    }
    
    public func getCats(completion: @escaping () -> Void) {
        catState = .loading
        completion()
        catLoader.load(completion: { [weak self] result in
            switch result {
            case .success(let cats):
                self?.catState = .success(cats)
            case .failure(let error):
                self?.catState = .failure(error)
            }
            completion()
        })
    }
    
    public func getImage(from id: String, completion: @escaping (DataStatePresenter<Data>) -> Void) {
        completion(.loading)
        catItemImageLoader.load(from: id) { imageResult in
            switch imageResult {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
