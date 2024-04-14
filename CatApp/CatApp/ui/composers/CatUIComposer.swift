//
//  CatUIComposer.swift
//  CatApp
//
//  Created by Jastin on 14/4/24.
//

import Foundation

public enum CatUIComposer {
    public static func catComposeWith(catLoader: CatLoader,
                                      imageLoaderAdapter: ImageLoaderAdapter) -> CatsViewController {
        let catRefreshViewController = CatsRefreshViewController(catLoader: catLoader)
        let catsViewController = CatsViewController(catRefreshViewController: catRefreshViewController)
        catRefreshViewController.onRefresh = { [weak catsViewController] cats in
            catsViewController?.tableModel = cats.map({ cat in
                return CatCellController(cat: cat, imageLoaderAdapter: imageLoaderAdapter)
            })
        }
        
        return catsViewController
    }
}
