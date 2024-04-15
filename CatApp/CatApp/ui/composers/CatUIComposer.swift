//
//  CatUIComposer.swift
//  CatApp
//
//  Created by Jastin on 14/4/24.
//

import Foundation
import UIKit

public enum CatUIComposer {
    
    public static func composeRoot() -> UINavigationController {
        let url = URL(string: "https://cataas.com/api/cats")!
        let client = URLSessionHTTPClient()
        let remoteCatLoader = RemoteCatLoader(url: url, client: client)
        let remoteImageLoader = RemoteImageLoader(client: client)
        let catItemLoaderAdapter = CatItemImageLoaderAdapter(path: "https://cataas.com/cat/", imageLoader: remoteImageLoader)
        let catsViewController = CatUIComposer.catComposeWith(catLoader: remoteCatLoader, imageLoaderAdapter: catItemLoaderAdapter)
        let rootNavigationController = UINavigationController(rootViewController: catsViewController)
        return rootNavigationController
    }
    
    public static func catComposeWith(catLoader: CatLoader,
                                      imageLoaderAdapter: ImageLoaderAdapter) -> CatsViewController {
        let catPresentationAdapter = CatPresentationAdapter(catLoader: catLoader)
        let catRefreshViewController = CatsRefreshViewController(delegate: catPresentationAdapter)
        let catsViewController = CatsViewController(catRefreshViewController: catRefreshViewController)
        let catViewAdapter = CatViewAdapter(catsViewController: catsViewController, imageLoaderAdapter: imageLoaderAdapter)
        catPresentationAdapter.catPresenter = CatPresenter(catLoadingView: WeakRefVirtualProxy(catRefreshViewController), catView: catViewAdapter)
        return catsViewController
    }
}

private final class WeakRefVirtualProxy<T: AnyObject> {
    
    private weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: CatLoadingView where T: CatLoadingView {
    func display(_ viewModel: CatLoadingViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: CatImageView where T: CatImageView, T.Image == UIImage {
    func display(_ viewModel: CatImageViewModel<UIImage>) {
        object?.display(viewModel)
    }
}

final class CatViewAdapter: CatView {
    
    private weak var catsViewController: CatsViewController?
    private let imageLoaderAdapter: ImageLoaderAdapter
    
    init(catsViewController: CatsViewController, imageLoaderAdapter: ImageLoaderAdapter) {
        self.catsViewController = catsViewController
        self.imageLoaderAdapter = imageLoaderAdapter
    }
    
    func display(_ viewModel: CatViewModel) {
        catsViewController?.tableModel = viewModel.cats.map({ cat in
            let catImagePresentationAdapter = CatImagePresentationAdapter<WeakRefVirtualProxy<CatCellController>, UIImage>(cat: cat,
                                                                                                                           imageLoaderAdapter: imageLoaderAdapter,
                                                                                                                           imageTransformer: UIImage.init)
            let catCellController = CatCellController(delegate: catImagePresentationAdapter)
            let catImagePresenter = CatImagePresenter(view: WeakRefVirtualProxy(catCellController), imageTransformation: UIImage.init)
            catImagePresentationAdapter.presenter = catImagePresenter
            return catCellController
        })
    }
}

private final class CatPresentationAdapter: CatsRefreshViewControllerDelegate {
    private let catLoader: CatLoader
    var catPresenter: CatPresenter?
    
    init(catLoader: CatLoader) {
        self.catLoader = catLoader
    }
    
    func didRequestCatRefresh() {
        catPresenter?.didStartLoadingCat()
        catLoader.load { [weak self ] result in
            switch result {
            case let .success(cats):
                self?.catPresenter?.didFinishedLoadingCat(with: cats)
            case let .failure(error):
                self?.catPresenter?.didFinishedLoadingCat(with: error)
            }
        }
    }
}


private final class CatImagePresentationAdapter<View: CatImageView, Image>: CatCellControllerDelegate where View.Image == Image {
    private var imageLoaderTask: ImageLoaderTask?
    private let cat: Cat
    private let imageLoaderAdapter: ImageLoaderAdapter
    private let imageTransformer: (Data) -> Image?
    var presenter: CatImagePresenter<View, Image>?
    
    init(imageLoaderTask: ImageLoaderTask? = nil,
         cat: Cat,
         imageLoaderAdapter: ImageLoaderAdapter,
         imageTransformer: @escaping (Data) -> Image?) {
        self.imageLoaderTask = imageLoaderTask
        self.cat = cat
        self.imageLoaderAdapter = imageLoaderAdapter
        self.imageTransformer = imageTransformer
    }
    
    func didRequestImage() {
        let cat = self.cat
        presenter?.didStartLoadingImageData(for: cat)
        imageLoaderTask = imageLoaderAdapter.load(from: cat.id, completion: { [weak self] imageResult in
            switch imageResult {
            case let .success(data):
                self?.presenter?.didFinishedLoadingImageData(with: data, for: cat)
            case let .failure(error):
                self?.presenter?.didFinishedLoadingImageData(with: error, for: cat)
            }
        })
    }
    
    func didCancelImageRequest() {
        imageLoaderTask?.cancel()
    }
}
