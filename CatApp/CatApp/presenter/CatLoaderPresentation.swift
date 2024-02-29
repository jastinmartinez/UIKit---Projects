//
//  CatViewModel.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import Foundation
import UIKit

public final class CatLoaderPresentation: CatPresenter {
    
    private let catLoader: CatLoader
    public var state: CatPresenterState
    public private(set) var cats: [Cat]
    
    public init(catLoader: CatLoader) {
        self.cats = []
        self.catLoader = catLoader
        self.state = .loading
    }
    
    public func load(completion: @escaping () -> Void) {
        state = .loading
        completion()
        catLoader.load(completion: { [weak self] result in
            switch result {
            case .success(let cats):
                self?.state = .success
                self?.cats = cats
            case .failure(let error):
                self?.state = .failure(error)
            }
            completion()
        })
    }
}
