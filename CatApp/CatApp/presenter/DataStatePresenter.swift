//
//  DataStatePresenter.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import Foundation

public enum DataStatePresenter<T> {
    case loading
    case success(T)
    case failure(Error)
}

extension DataStatePresenter {
    @discardableResult func onSuccess(completion: (T) -> Void) -> Self {
        guard case let .success(value) = self else {
            return self
        }
        completion(value)
        return self
    }
}
