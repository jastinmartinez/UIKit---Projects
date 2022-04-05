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
    
    private lazy var showSearchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: NameHelper.cell.rawValue)
        return tableView
    }()
    
    init(showViewModel: ShowViewModel) {
        self.showViewModel = showViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewConfiguration()
        self.setShowSearchResultTableView()
    }
    
    fileprivate func setViewConfiguration() {
        self.view.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)!
    }
    
    func searchFor(text: String) {
        DispatchQueue.main.async {
            self.showEntityList = self.showViewModel.showEntityList.filter({ showEntity in showEntity.name.contains(text)})
            self.showSearchResultTableView.reloadData()
        }
    }

    fileprivate func setShowSearchResultTableView() {
        self.view.addSubview(self.showSearchResultTableView)
        self.showSearchResultTableView.dataSource = self
        self.showSearchResultTableView.delegate = self
        NSLayoutConstraint.on([self.showSearchResultTableView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
                               self.showSearchResultTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor)])
    }
}

extension ShowSearchResultTableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showEntityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showTableViewCell = tableView.dequeueReusableCell(withIdentifier:  NameHelper.cell.rawValue) as? ShowTableViewCell
        showTableViewCell?.accessoryType = .detailDisclosureButton
        showTableViewCell?.selectionStyle = .none
        self.showViewModel.fectShowImage(indexPath.row) { showEntity in
            showTableViewCell?.setShowEntity(showEntity)
        }
        return showTableViewCell!
    }
}
    
extension ShowSearchResultTableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

