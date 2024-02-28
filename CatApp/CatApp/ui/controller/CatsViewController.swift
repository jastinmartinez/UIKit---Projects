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
        xTableView.translatesAutoresizingMaskIntoConstraints = false
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
        catPresenter.load { [weak self] in
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
        if case .success = catPresenter.state {
            catTableView.separatorStyle = .singleLine
        } else {
            catTableView.separatorStyle = .none
        }
    }
}

extension CatsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch catPresenter.state {
        case .loading:
            return setLoadingCell(tableView, indexPath)
        case .success:
            return setSuccessCell(tableView, indexPath)
        case .failure:
            return setFailureCell(tableView, indexPath)
        }
    }
}

extension CatsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCat(indexPath.row)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension CatsViewController {
    private func setLoadingCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(for: indexPath) as CatLoadingTableViewCell
    }
    
    private func setSuccessCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(for: indexPath) as CatTableViewCell
    }
    
    private func setFailureCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(for: indexPath) as CatErrorTableViewCell
    }
    
    private var numberOfRowsInSection: Int {
        return catPresenter.cats.count == 0 ? 1 : catPresenter.cats.count
    }
}
