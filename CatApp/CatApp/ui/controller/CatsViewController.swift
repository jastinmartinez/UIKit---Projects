//
//  ViewController.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import UIKit


public class CatsViewController: UITableViewController {
    
    private var catLoader: CatLoader?
    private var imageLoaderAdapter: ImageLoaderAdapter?
    private var tableModel = [Cat]()
    private var imageTasks = [IndexPath: ImageLoaderTask]()
    
    public convenience init(catLoader: CatLoader,
                            imageLoaderAdapter: ImageLoaderAdapter) {
        self.init()
        self.catLoader = catLoader
        self.imageLoaderAdapter = imageLoaderAdapter
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
        load()
    }
    
    private func registerCell() {
        tableView.register(CatTableViewCell.self, forCellReuseIdentifier: CatTableViewCell.name)
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        refreshControl?.beginRefreshing()
    }
    
    @objc private func load() {
        catLoader?.load { [weak self] result in
            if let cats = try? result.get() {
                self?.tableModel = cats
                self?.tableView.reloadData()
            }
            self?.refreshControl?.endRefreshing()
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let catCell: CatTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let cat = tableModel[indexPath.row]
        catCell.setCat(cat)
        catCell.retryButton.isHidden = true
        catCell.catImageView.image = nil
        catCell.containerView.startShimmering()
        let loadImage = { [weak self, weak catCell] in
            guard let self = self else { return }
            self.imageTasks[indexPath] = self.imageLoaderAdapter?.load(from: cat.id, completion: { [weak catCell] result in
                let data = try? result.get()
                let image = data.map(UIImage.init) ?? nil
                catCell?.catImageView.image = image
                catCell?.retryButton.isHidden = (image != nil)
                catCell?.containerView.stopShimmering()
            })
        }
        catCell.onRetry = loadImage
        loadImage()
        return catCell
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        imageTasks[indexPath]?.cancel()
        imageTasks[indexPath] = nil
    }
}
