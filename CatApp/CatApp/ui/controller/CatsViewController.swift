//
//  ViewController.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import UIKit

public class CatsViewController: UIViewController {
    
    public private(set) var catPresenter: CatPresenter
    private var didSelectCat: (Int) -> Void
    
    public let catTableView: UITableView = {
        let xTableView = UITableView()
        xTableView.register(CatLoadingTableViewCell.self, forCellReuseIdentifier: CatLoadingTableViewCell.name)
        xTableView.register(CatTableViewCell.self, forCellReuseIdentifier: CatTableViewCell.name)
        xTableView.register(CatErrorTableViewCell.self, forCellReuseIdentifier: CatErrorTableViewCell.name)
        return xTableView
    }()
    
    public init(catPresenter: CatPresenter,
                didSelectCat: @escaping (Int) -> Void) {
        self.catPresenter = catPresenter
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
        catPresenter.load { [weak self] in
            self?.catTableView.reloadData()
        }
    }
}

extension CatsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catPresenter.cats.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch catPresenter.state {
        case .loading:
            return tableView.dequeueReusableCell(for: indexPath) as CatLoadingTableViewCell
        case .success:
            return tableView.dequeueReusableCell(for: indexPath) as CatTableViewCell
        case .failure:
            return tableView.dequeueReusableCell(for: indexPath) as CatErrorTableViewCell
        }
    }
}

extension CatsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCat(indexPath.row)
    }
}
