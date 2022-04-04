//
//  ShowTableViewController.swift
//  TVShowApp
//
//  Created by Jastin on 3/4/22.
//

import UIKit
import PresentationLayer
import DomainLayer

class ShowTableViewController : UIViewController {
    private var fetchingActivityIndicator = UIActivityIndicatorView(style: .medium)
    private var showViewModel: ShowViewModel!
    
    private lazy var showTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: "cell")
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
        self.setShowTableView()
        self.showViewModel.fetchShowList()
        self.showViewModel.didSetShowEntityList = self
    }
    
    fileprivate func setViewConfiguration() {
        self.view.backgroundColor = .white
    }

    fileprivate func setShowTableView() {
        self.view.addSubview(self.showTableView)
        self.showTableView.dataSource = self
        self.showTableView.prefetchDataSource = self
        self.showTableView.delegate = self
        NSLayoutConstraint.on([self.showTableView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
                               self.showTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor)])
    }
}

extension ShowTableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showViewModel.showEntityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ShowTableViewCell
        showTableViewCell?.accessoryType = .detailDisclosureButton
        showTableViewCell?.selectionStyle = .none
        self.showViewModel.fectShowImage(self.showViewModel.showEntityList[indexPath.row]) { showEntity in
            showTableViewCell?.setShowEntity(showEntity)
        }
        return showTableViewCell!
    }
}

extension ShowTableViewController : UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            self.showViewModel.fectShowImage(self.showViewModel.showEntityList[indexPath.row], handler: nil)
        }
    }
}

extension ShowTableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
extension ShowTableViewController : DidSetShowEntityList {
    func notifyViewController() {
        DispatchQueue.main.async {
            self.showTableView.reloadData()
        }
    }
}
