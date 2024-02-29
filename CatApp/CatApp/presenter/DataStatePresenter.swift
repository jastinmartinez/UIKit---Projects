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
