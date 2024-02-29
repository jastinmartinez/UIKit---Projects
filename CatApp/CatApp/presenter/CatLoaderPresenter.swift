//
//  CatPresenter.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import Foundation

public protocol CatLoaderPresenter {
    func load(completion: @escaping () -> Void)
    var cats: [Cat] { get }
    var state: CatPresenterState { get }
}
