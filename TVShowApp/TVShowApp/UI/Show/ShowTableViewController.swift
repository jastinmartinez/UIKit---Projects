//
//  ShowTableViewController.swift
//  TVShowApp
//
//  Created by Jastin on 3/4/22.
//

import UIKit
import PresentationLayer
import DomainLayer


enum ShowEntitySort : String , CaseIterable {
    case name = "Name"
    case favorite = "Favorite"
}
public class ShowTableViewController : UIViewController {
    
    public private(set) var showViewModel: ShowViewModel!
    private var showEpisodeViewModel: ShowEpisodeViewModel!
    private var showSearchController: UISearchController!
    public lazy var fetchingActivityIndicator = UIActivityIndicatorView.buildActivityIndicator()
    private var showEntitySortOrderSegmentedControl = UISegmentedControl(items: ShowEntitySort.allCases.map({ $0.rawValue }))
     public lazy var showTableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelection = false
        tableView.isMultipleTouchEnabled = false
        tableView.backgroundColor = UIColor(named: ColorHelper.white.rawValue)!
        tableView.dataSource = self
        tableView.layer.cornerRadius = 30
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: NameHelper.cell.rawValue)
        return tableView
    }()
    
    public init(showViewModel: ShowViewModel,showEpisodeViewModel: ShowEpisodeViewModel) {
        self.showViewModel = showViewModel
        self.showEpisodeViewModel = showEpisodeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        didSetShowEntities()
        setViewConfiguration()
        setOutletToSubView()
        setActivityIndicatorConstraint()
        setShowTableView()
        showViewModel.fetchShowList()
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
    
    private func didSetShowEntities() {
        showViewModel.showsState = { [weak self] state in
            switch state {
            case .loading:
                self?.fetchingActivityIndicator.startAnimating()
            case .done:
                DispatchQueue.main.async { [weak self] in
                    self?.showTableView.reloadData()
                    self?.fetchingActivityIndicator.stopAnimating()
                }
            case .fail(_):
                break
            }
        }
    }
}

extension ShowTableViewController : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showViewModel.showEntityList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showTableViewCell = tableView.dequeueReusableCell(withIdentifier: NameHelper.cell.rawValue) as? ShowTableViewCell
        showTableViewCell?.tintColor = UIColor(named: ColorHelper.red.rawValue)
        showTableViewCell?.selectionStyle = .none
        return showTableViewCell!
    }
}
