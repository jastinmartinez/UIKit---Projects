//
//  CatViewModel.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import Foundation
import UIKit

public protocol IdentifiableCell: AnyObject {
     static var name: String { get }
}

extension IdentifiableCell where Self: UITableViewCell {
    public static var name: String {
        String(describing: self)
    }
}

public final class CatViewModel: CatPresenter {
    
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
    
    public func identifiableCell() -> IdentifiableCell {
        switch state {
        case .loading:
            return CatLoadingTableViewCell()
        case .success:
            return CatTableViewCell()
        case .failure:
            return CatErrorTableViewCell()
        }
    }
}
