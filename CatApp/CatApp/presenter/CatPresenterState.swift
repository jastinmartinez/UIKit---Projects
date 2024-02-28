//
//  CatPresenterState.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import Foundation

public enum CatPresenterState {
    case loading
    case success
    case failure(Error)
}