//
//  ViewController.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import UIKit


public class CatsViewController: UITableViewController {
    
    private(set) public var catRefreshViewController: CatsRefreshViewController?
    private var imageLoaderAdapter: ImageLoaderAdapter?
    private var tableModel = [Cat]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    private var catCellControllers = [IndexPath: CatCellController]()
    
    public convenience init(catLoader: CatLoader,
                            imageLoaderAdapter: ImageLoaderAdapter) {
        self.init()
        self.catRefreshViewController = CatsRefreshViewController(catLoader: catLoader)
        self.imageLoaderAdapter = imageLoaderAdapter
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        refreshControl = catRefreshViewController?.view
        catRefreshViewController?.onRefresh = { [weak self] cats in
            self?.tableModel = cats
        }
        catRefreshViewController?.refresh()
        tableView.prefetchDataSource = self
    }
    
    private func registerCell() {
        tableView.register(CatTableViewCell.self, forCellReuseIdentifier: CatTableViewCell.name)
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        refreshControl?.beginRefreshing()
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return catCellViewControllerForRowAt(indexPath).view(tableView, cellForRowAt: indexPath)
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        removeCatCellController(forRowAt: indexPath)
    }
    
    private func removeCatCellController(forRowAt indexPath: IndexPath) {
        catCellControllers[indexPath] = nil
    }
    
    private func catCellViewControllerForRowAt(_ indexPath: IndexPath) -> CatCellController {
        let cat = tableModel[indexPath.row]
        let  catCellController = CatCellController(cat: cat,
                                                   imageLoaderAdapter: imageLoaderAdapter!)
        catCellControllers[indexPath] = catCellController
        return catCellController
    }
}

extension CatsViewController: UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            catCellViewControllerForRowAt(indexPath).preload()
        }
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach(removeCatCellController)
    }
}
