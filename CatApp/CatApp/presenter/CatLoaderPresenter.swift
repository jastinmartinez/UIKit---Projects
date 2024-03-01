//
//  CatPresenter.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import Foundation

public protocol CatLoaderPresenter {
    var catState: DataStatePresenter<[Cat]> { get }
    func getCats(completion: @escaping () -> Void)
    func getImage(from id: String, completion: @escaping (DataStatePresenter<Data>) -> Void)
}
