//
//  ViewController.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import UIKit


public class CatsViewController: UITableViewController {
    
    private var catLoader: CatLoader?
    
    public convenience init(catLoader: CatLoader) {
        self.init()
        self.catLoader = catLoader
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
        load()
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        refreshControl?.beginRefreshing()
    }
    
    @objc private func load() {
        catLoader?.load { [weak self] _ in
            self?.refreshControl?.endRefreshing()
        }
    }
}
