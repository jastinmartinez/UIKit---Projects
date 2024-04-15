//
//  CatImagePresenter.swift
//  CatApp
//
//  Created by Jastin on 14/4/24.
//

import Foundation

protocol CatImageView {
    associatedtype Image
    func display(_ viewModel: CatImageViewModel<Image>)
}

final class CatImagePresenter<View: CatImageView, Image> where View.Image == Image {
    
    private let view: View
    private let imageTransformation: (Data) -> Image?
    
    init(view: View, imageTransformation: @escaping (Data) -> Image?) {
        self.view = view
        self.imageTransformation = imageTransformation
    }
    
    func didStartLoadingImageData(for model: Cat) {
        view.display(CatImageViewModel(tags: model.tags,
                                       image: nil,
                                       isLoading: true,
                                       shouldRetry: false))
    }
    
    enum Error: Swift.Error {
        case InvalidImage
    }
    
    func didFinishedLoadingImageData(with data: Data, for model: Cat) {
        guard let image = imageTransformation(data) else {
            return didFinishedLoadingImageData(with: Error.InvalidImage, for: model)
        }
        view.display(CatImageViewModel(tags: model.tags,
                                       image: image,
                                       isLoading: false,
                                       shouldRetry: false))
    }
    
    func didFinishedLoadingImageData(with error: Swift.Error, for model: Cat) {
        view.display(CatImageViewModel(tags: model.tags,
                                       image: nil,
                                       isLoading: false,
                                       shouldRetry: true))
    }
}
