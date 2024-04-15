//
//  ViewController.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import UIKit

public class CatsViewController: UITableViewController, UITableViewDataSourcePrefetching {
    
    private(set) public var catRefreshViewController: CatsRefreshViewController?
    
    public var tableModel = [CatCellController]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    convenience init(catRefreshViewController: CatsRefreshViewController) {
        self.init()
        self.catRefreshViewController = catRefreshViewController
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        onCreate()
    }
    
    private func onCreate() {
        setCell()
        setRefreshControlControl()
        catRefreshViewController?.refresh()
        setPrefetchDelegate()
    }
    
    private func setPrefetchDelegate() {
        tableView.prefetchDataSource = self
    }
    
    private func setRefreshControlControl() {
        refreshControl = catRefreshViewController?.view
    }
    
    private func setCell() {
        tableView.register(CatTableViewCell.self, forCellReuseIdentifier: CatTableViewCell.name)
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        catRefreshViewController?.beginRefreshing?()
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
        tableModel[indexPath.row].cancel()
    }
    
    private func catCellViewControllerForRowAt(_ indexPath: IndexPath) -> CatCellController {
        return tableModel[indexPath.row]
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            catCellViewControllerForRowAt(indexPath).preload()
        }
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach(removeCatCellController)
    }
}
