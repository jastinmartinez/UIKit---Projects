//
//  CatPresenter.swift
//  CatApp
//
//  Created by Jastin on 14/4/24.
//

import Foundation

protocol CatView {
    func display(_ viewModel: CatViewModel)
}

protocol CatLoadingView {
    func display(_ viewModel: CatLoadingViewModel)
}

final class CatPresenter {
    
    private let catLoadingView: CatLoadingView
    private let catView: CatView
    
    init(catLoadingView: CatLoadingView, catView: CatView) {
        self.catLoadingView = catLoadingView
        self.catView = catView
    }
    
    func didStartLoadingCat() {
        catLoadingView.display(CatLoadingViewModel(isLoading: true))
    }
    
    func didFinishedLoadingCat(with cats: [Cat]) {
        catView.display(CatViewModel(cats: cats))
        catLoadingView.display(CatLoadingViewModel(isLoading: false))
    }
    
    func didFinishedLoadingCat(with error: Error) {
        catLoadingView.display(CatLoadingViewModel(isLoading: false))
    }
}
