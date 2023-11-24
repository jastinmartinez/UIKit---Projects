//
//  ShowSearchResultTableViewController.swift
//  TVShowApp
//
//  Created by Jastin on 4/4/22.
//

import UIKit
import DomainLayer
import PresentationLayer

class ShowSearchResultTableViewController : UIViewController {
    
    private var showEntityList = [ShowEntity]()
    private var showViewModel: ShowViewModel!
    private var showEpisodeViewModel: ShowEpisodeViewModel!
    private lazy var fetchingActivityIndicator = UIActivityIndicatorView.buildActivityIndicator()
    
    private lazy var showSearchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: ColorHelper.white.rawValue)!
        tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: NameHelper.cell.rawValue)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    init(showViewModel: ShowViewModel, showEpisodeViewModel: ShowEpisodeViewModel) {
        self.showViewModel = showViewModel
        self.showEpisodeViewModel = showEpisodeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewConfiguration()
        self.setShowSearchResultTableView()
        self.setActivityIndicator()
    }
    
    fileprivate func setViewConfiguration() {
        self.view.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)!
    }
    
    func searchFor(text: String) {
        DispatchQueue.main.async {
            self.showEntityList = self.showViewModel.showEntities.filter({ showEntity in showEntity.name.lowercased().contains(text.lowercased())})
            self.showSearchResultTableView.reloadData()
        }
    }

    fileprivate func setShowSearchResultTableView() {
        self.view.addSubview(self.showSearchResultTableView)
        NSLayoutConstraint.on([self.showSearchResultTableView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
                               self.showSearchResultTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                               self.showSearchResultTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                               self.showSearchResultTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
    }
    
    fileprivate func setActivityIndicator() {
        self.view.addSubview(self.fetchingActivityIndicator)
        NSLayoutConstraint.on([self.fetchingActivityIndicator.centerXAnchor.constraint(equalTo: self.showSearchResultTableView.centerXAnchor),
                               self.fetchingActivityIndicator.centerYAnchor.constraint(equalTo: self.showSearchResultTableView.centerYAnchor)])
    }
}

extension ShowSearchResultTableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showEntityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showTableViewCell = tableView.dequeueReusableCell(withIdentifier:  NameHelper.cell.rawValue) as? ShowTableViewCell
        showTableViewCell?.tintColor = UIColor(named: ColorHelper.red.rawValue)
        showTableViewCell?.selectionStyle = .none
        showTableViewCell?.didChangeShowEntity = self
        return showTableViewCell!
    }
}
    
extension ShowSearchResultTableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.fetchingActivityIndicator.startAnimating()
        self.showEpisodeViewModel.fetchShowEpisodeListById(showId: self.showEntityList[indexPath.row].id)
        self.showEpisodeViewModel.didSetShowEpisodeEntityList = self
    }
}

extension ShowSearchResultTableViewController : DidChangeShowEntity {
    func didChangeShowEntity(_ showEntity: ShowEntity) {
       
    }
}

extension ShowSearchResultTableViewController : DidSetShowEpisodeEntityList {
    func DidSetShowEpisodeEntityListNotification() {
        self.fetchingActivityIndicator.stopAnimating()
    }
}
