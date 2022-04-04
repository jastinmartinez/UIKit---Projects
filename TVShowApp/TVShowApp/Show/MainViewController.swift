//
//  MainViewController.swift
//  TVShowApp
//
//  Created by Jastin on 1/4/22.
//

import UIKit
import PresentationLayer

class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConfiguration()
    }
    
    fileprivate func setConfiguration() {
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor(named: "D82148")!
        self.tabBar.barTintColor = UIColor(named: "151D3B")!
        let showViewModel = ShowDependencyInjection().setShowViewModelDependecy()
        let showViewController = ShowTableViewController(showViewModel: showViewModel)
        showViewController.tabBarItem = UITabBarItem(title: "Ticket", image: UIImage(systemName: "ticket"), selectedImage: UIImage(systemName: "ticket"))
        
        let configurationViewController =  ConfigurationViewController()
        configurationViewController.tabBarItem = UITabBarItem(title: "Configuration", image: UIImage(systemName: "gear.circle"), selectedImage: UIImage(systemName: "gear.circle"))
        self.setViewControllers([ showViewController,configurationViewController], animated: false)
    }
}
