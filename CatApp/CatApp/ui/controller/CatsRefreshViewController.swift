//
//  CatsRefreshViewController.swift
//  CatApp
//
//  Created by Jastin on 14/4/24.
//

import Foundation
import UIKit

public class CatsRefreshViewController: NSObject {
    
    public lazy var view: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    private let catLoader: CatLoader
    
    init(catLoader: CatLoader) {
        self.catLoader = catLoader
    }
    
    var onRefresh: (([Cat]) -> Void)?
    
    @objc func refresh() {
        catLoader.load { [weak self] result in
            if let cats = try? result.get() {
                self?.onRefresh?(cats)
            }
            self?.view.endRefreshing()
        }
    }
}
