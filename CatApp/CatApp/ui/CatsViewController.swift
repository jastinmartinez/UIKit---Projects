//
//  ViewController.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import UIKit

public class CatsViewController: UIViewController {
    
    private let catLoader: CatLoader
    public private(set) var cats = [Cat]()
    private var catLoaderState: CatLoaderState = .loading
    private var didSelectCat: (Int) -> Void
    
    public let catTableView: UITableView = {
        let xTableView = UITableView()
        return UITableView()
    }()
    
    public init(catLoader: CatLoader, didSelectCat: @escaping (Int) -> Void) {
        self.catLoader = catLoader
        self.didSelectCat = didSelectCat
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("Can't load \(String(describing: CatsViewController.self))")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        onCreate()
    }
    
    private func onCreate() {
        setCatTableViewDelegates()
        getCats()
    }
    
    private func setCatTableViewDelegates() {
        catTableView.dataSource = self
        catTableView.delegate = self
    }
    
    private func getCats() {
        catLoader.load { [weak self] catLoaderResult in
            if case let .success(array) = catLoaderResult {
                self?.cats = array
                self?.catLoaderState = .success
                self?.catTableView.reloadData()
            } else {
                self?.catLoaderState = .failure
            }
        }
    }
}

extension CatsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch catLoaderState {
        case  .failure:
            return CatErrorTableViewCell()
        case .loading:
            return CatLoadingTableViewCell()
        case .success:
            return CatTableViewCell()
        }
    }
}

extension CatsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCat(indexPath.row)
    }
}

extension CatsViewController {
    public enum CatLoaderState {
        case failure
        case loading
        case success
    }
}


public class CatErrorTableViewCell: UITableViewCell { }

public class CatLoadingTableViewCell: UITableViewCell { }

public class CatTableViewCell: UITableViewCell { }
