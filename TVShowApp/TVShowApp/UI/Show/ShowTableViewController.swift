//
//  ShowTableViewController.swift
//  TVShowApp
//
//  Created by Jastin on 3/4/22.
//

import UIKit
import PresentationLayer
import DomainLayer


public class ShowTableViewController : UIViewController {
    
    private var showViewModelAction: ShowViewModelActions!
    public var didSelectShow: ((Int) -> Void)?
    
    public let fetchingActivityIndicator: UIActivityIndicatorView = {
        return  UIActivityIndicatorView.buildActivityIndicator()
    }()
    
    public let showTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: NameHelper.cell.rawValue)
        return tableView
    }()
    
    public init(showViewModelAction: ShowViewModelActions) {
        self.showViewModelAction = showViewModelAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        onCreate()
    }
   
    private func onCreate() {
        setShowDataState()
        setViewConfiguration()
        setOutletToSubView()
        setShowTableView()
        setActivityIndicatorConstraint()
        setDelegates()
        fetchShows()
    }
    
    private func fetchShows() {
        showViewModelAction.fetchShows()
    }
    
    private func fetchNextShows() {
        showViewModelAction.fetchNextShows()
    }
    
    private func setDelegates() {
        showTableView.dataSource = self
        showTableView.delegate = self
    }
    
    private func setOutletToSubView() {
        view.addSubview(showTableView)
        view.addSubview(fetchingActivityIndicator)
    }
    
    private func setViewConfiguration() {
        view.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)!
    }
    
    private func setShowTableView() {
        NSLayoutConstraint.on([showTableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                               showTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                               showTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                               showTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func setActivityIndicatorConstraint() {
        NSLayoutConstraint.on([fetchingActivityIndicator.centerXAnchor.constraint(equalTo: showTableView.centerXAnchor),
                               fetchingActivityIndicator.centerYAnchor.constraint(equalTo: showTableView.centerYAnchor)])
    }
    
    private func setShowDataState() {
        showViewModelAction.showsState = {  [weak self] state in
            switch state {
            case .loading:
                self?.fetchingActivityIndicator.startAnimating()
            case .done:
                self?.showTableView.reloadData()
                self?.fetchingActivityIndicator.stopAnimating()
            case .fail(_):
                self?.fetchingActivityIndicator.stopAnimating()
            }
        }
    }
}

extension ShowTableViewController : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showViewModelAction.shows.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showTableViewCell = tableView.dequeueReusableCell(withIdentifier: NameHelper.cell.rawValue) as? ShowTableViewCell
        showTableViewCell?.tintColor = UIColor(named: ColorHelper.red.rawValue)
        showTableViewCell?.selectionStyle = .none
        return showTableViewCell!
    }
}

extension ShowTableViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectShow?(indexPath.row)
    }
}

extension ShowTableViewController {
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if showTableView.contentOffset.y >= (showTableView.contentSize.height - showTableView.frame.size.height) {
            fetchNextShows()
        }
    }
}
