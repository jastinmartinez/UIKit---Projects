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
    
    private var showViewModelInteraction: ShowViewModelInteraction!
    private var showEpisodeViewModel: ShowEpisodeViewModel!
    public lazy var fetchingActivityIndicator = UIActivityIndicatorView.buildActivityIndicator()
    
    public let showTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: NameHelper.cell.rawValue)
        return tableView
    }()
    
    public init(showViewModelInteraction: ShowViewModelInteraction,showEpisodeViewModel: ShowEpisodeViewModel) {
        self.showViewModelInteraction = showViewModelInteraction
        self.showEpisodeViewModel = showEpisodeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        onCreate()
    }
   
    fileprivate func onCreate() {
        setViewConfiguration()
        setOutletToSubView()
        setShowTableView()
        setActivityIndicatorConstraint()
        setDelegates()
        setShowDataState()
        fetchShows()
    }
    
    fileprivate func fetchShows() {
        showViewModelInteraction.fetchShows()
    }
    
    private func setDelegates() {
        showTableView.dataSource = self
    }
    
    fileprivate func setOutletToSubView() {
        view.addSubview(showTableView)
        view.addSubview(fetchingActivityIndicator)
    }
    
    fileprivate func setViewConfiguration() {
        view.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)!
    }
    
    fileprivate func setShowTableView() {
        NSLayoutConstraint.on([showTableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                               showTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                               showTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                               showTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    fileprivate func setActivityIndicatorConstraint() {
        NSLayoutConstraint.on([fetchingActivityIndicator.centerXAnchor.constraint(equalTo: showTableView.centerXAnchor),
                               fetchingActivityIndicator.centerYAnchor.constraint(equalTo: showTableView.centerYAnchor)])
    }
    
    public func setShowDataState() {
        showViewModelInteraction.showsState = {  [weak self] state in
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
        return showViewModelInteraction.showEntities.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showTableViewCell = tableView.dequeueReusableCell(withIdentifier: NameHelper.cell.rawValue) as? ShowTableViewCell
        showTableViewCell?.tintColor = UIColor(named: ColorHelper.red.rawValue)
        showTableViewCell?.selectionStyle = .none
        return showTableViewCell!
    }
}
