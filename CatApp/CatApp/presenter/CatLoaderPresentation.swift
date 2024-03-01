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
    public private(set) var imageForCatDictionary = [String: Cat]()
    public var cats: [Cat] {
        return imageForCatDictionary
            .map({ $0.value })
            .sorted(by: { $0.id < $1.id })
    }
    
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
                self?.mapImageToCatDictionary(cats)
                self?.mapToCats()
            case .failure(let error):
                self?.catState = .failure(error)
            }
            completion()
        })
    }
    
    private func mapImageToCatDictionary(_ cats: [Cat]) {
        for cat in cats {
            imageForCatDictionary[cat.id] = cat
        }
    }
    
    public func getImage(from id: String, completion: @escaping (DataStatePresenter<Data>) -> Void) {
        completion(.loading)
        catItemImageLoader.load(from: id) { [weak self] imageResult in
            switch imageResult {
            case .success(let data):
                self?.mapImageToCat(for: id, with: data)
                self?.mapToCats()
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func mapImageToCat(for id: String, with data: Data) {
        if let cat = imageForCatDictionary[id]{
            imageForCatDictionary[id] = cat.copy(with: data)
        }
    }
    
    private func mapToCats() {
        catState = .success(cats)
    }
}
