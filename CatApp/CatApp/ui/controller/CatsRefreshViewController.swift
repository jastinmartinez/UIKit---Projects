//
//  CatsRefreshViewController.swift
//  CatApp
//
//  Created by Jastin on 14/4/24.
//

import Foundation
import UIKit

protocol CatsRefreshViewControllerDelegate {
    func didRequestCatRefresh()
}

public class CatsRefreshViewController: NSObject, CatLoadingView {
    public lazy var view = loadView()
    private(set) var beginRefreshing: (() -> Void)?
    private let delegate: CatsRefreshViewControllerDelegate
    
    init(delegate: CatsRefreshViewControllerDelegate) {
        self.delegate = delegate
    }
    
    @objc func refresh() {
        delegate.didRequestCatRefresh()
    }
    
    func display(_ viewModel: CatLoadingViewModel) {
        if viewModel.isLoading {
            beginRefreshing = { [weak self] in
                self?.view.beginRefreshing()
            }
        } else {
            view.endRefreshing()
        }
    }
    
    private func loadView() -> UIRefreshControl {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
}
