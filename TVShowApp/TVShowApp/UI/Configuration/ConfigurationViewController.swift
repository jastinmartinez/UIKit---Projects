//
//  ConfigurationViewController.swift
//  TVShowApp
//
//  Created by Jastin on 3/4/22.
//

import UIKit
class ConfigurationViewController: UIViewController {
    
    private lazy var configurationTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)
        tableView.register(ConfigurationTableViewCell.self, forCellReuseIdentifier: NameHelper.cell.rawValue)
        tableView.layer.cornerRadius = 30
        tableView.clipsToBounds = true
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewConfiguration()
        self.setConfigurationTableView()
    }
    
    fileprivate func setViewConfiguration() {
        self.view.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)!
    }
    
    fileprivate func setConfigurationTableView() {
        self.view.addSubview(configurationTableView)
        NSLayoutConstraint.on([self.configurationTableView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor,constant: 20),
                               self.configurationTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                               self.configurationTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                               self.configurationTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
    }
}

extension ConfigurationViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurationTableView = tableView.dequeueReusableCell(withIdentifier: NameHelper.cell.rawValue, for: indexPath) as? ConfigurationTableViewCell
        configurationTableView?.setConfiguration(name: "Biometrical Authentication", image: UIImage(systemName: "faceid"))
        configurationTableView?.selectionStyle = .none
        return configurationTableView!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Details"
    }
}
