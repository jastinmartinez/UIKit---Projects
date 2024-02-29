//
//  ViewController.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import UIKit

public class CatsViewController: UIViewController {
    
    public private(set) var catPresenter: CatLoaderPresenter
    public var didSelectCat: ((Int) -> Void)?
    
    public let catTableView: UITableView = {
        let xTableView = UITableView()
        xTableView.translatesAutoresizingMaskIntoConstraints = false
        xTableView.register(CatLoadingTableViewCell.self, forCellReuseIdentifier: CatLoadingTableViewCell.name)
        xTableView.register(CatTableViewCell.self, forCellReuseIdentifier: CatTableViewCell.name)
        xTableView.register(CatErrorTableViewCell.self, forCellReuseIdentifier: CatErrorTableViewCell.name)
        return xTableView
    }()
    
    public init(catPresenter: CatLoaderPresenter) {
        self.catPresenter = catPresenter
        self.didSelectCat = nil
        super.init(nibName: nil, bundle: nil)
        self.title = "Catify"
    }
    
    public required init?(coder: NSCoder) {
        fatalError("Can't load \(String(describing: CatsViewController.self))")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        onCreate()
    }
    
    private func onCreate() {
        setCatTableViewToSubView()
        setCatTableViewConstraint()
        setCatTableViewDelegates()
        getCats()
    }
    
    private func setCatTableViewToSubView() {
        view.addSubview(catTableView)
    }
    
    private func setCatTableViewConstraint() {
        NSLayoutConstraint.activate([catTableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     catTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     catTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     catTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func setCatTableViewDelegates() {
        catTableView.dataSource = self
        catTableView.delegate = self
    }
    
    private func getCats() {
        catPresenter.getCats { [weak self] in
            DispatchQueue.main.async { 
                self?.reloadData()
                self?.setSeparatorToTableView()
            }
        }
    }
    
    private func reloadData() {
        catTableView.reloadData()
    }
    
    private func setSeparatorToTableView() {
        if case .success = catPresenter.catState {
            catTableView.separatorStyle = .singleLine
        } else {
            catTableView.separatorStyle = .none
        }
    }
}

extension CatsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch catPresenter.catState {
        case .loading:
            return 1
        case .success(let cats):
            return cats.count
        case .failure:
            return 1
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch catPresenter.catState {
        case .loading:
            return setLoadingCell(tableView, indexPath)
        case .success(let cats):
            return setSuccessCell(tableView, indexPath, cats)
        case .failure:
            return setFailureCell(tableView, indexPath)
        }
    }
}

extension CatsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCat?(indexPath.row)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension CatsViewController {
    private func setLoadingCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(for: indexPath) as CatLoadingTableViewCell
    }
    
    private func setSuccessCell(_ tableView: UITableView,
                                _ indexPath: IndexPath,
                                _ cats: [Cat]) -> UITableViewCell {
        let catTableViewCell = tableView.dequeueReusableCell(for: indexPath) as CatTableViewCell
        catTableViewCell.setCat(cats[indexPath.row])
        catPresenter.getImage(from: cats[indexPath.row].id,
                              completion: catTableViewCell.setImage)
        return catTableViewCell
    }
    
    private func setFailureCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(for: indexPath) as CatErrorTableViewCell
    }
}
