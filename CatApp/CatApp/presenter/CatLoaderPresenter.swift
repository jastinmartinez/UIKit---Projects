//
//  CatPresenter.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import Foundation

public protocol CatLoaderPresenter {
    func getCats(completion: @escaping () -> Void)
    var catState: DataStatePresenter<[Cat]> { get }
}
