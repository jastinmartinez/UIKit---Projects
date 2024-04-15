//
//  CatImageViewModel.swift
//  CatApp
//
//  Created by Jastin on 14/4/24.
//

import Foundation

struct CatImageViewModel<Image> {
    let tags: [String]?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
}
