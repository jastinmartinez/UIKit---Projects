//
//  CatPresenter.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import Foundation

public protocol CatPresenter {
    func load()
    var state: (CatPresenterState) -> Void { get }
}
