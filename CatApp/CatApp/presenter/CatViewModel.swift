//
//  CatViewModel.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import Foundation

public final class CatViewModel: CatPresenter {
    
    private let catLoader: CatLoader
    private(set) public var state: (CatPresenterState) -> Void
    public private(set) var cats: [Cat]
    
    public init(catLoader: CatLoader,
                state: @escaping (CatPresenterState) -> Void) {
        self.cats = []
        self.catLoader = catLoader
        self.state = state
    }
    
    public func load() {
        state(.loading)
        catLoader.load(completion: { [weak self] result in
            switch result {
            case .success(let cats):
                self?.state(.success)
                self?.cats = cats
            case .failure(let error):
                self?.state(.failure(error))
            }
        })
    }
}
