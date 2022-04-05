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
        self.tabBar.tintColor = UIColor(named: ColorHelper.red.rawValue)!
        self.view.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)!
        let showViewModel = ShowDependencyInjection().setShowViewModelDependecy()
        let showViewController = UINavigationController(rootViewController: ShowTableViewController(showViewModel: showViewModel))
        showViewController.navigationBar.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)!
        showViewController.tabBarItem = UITabBarItem(title: "TV Shows", image: UIImage(systemName: "ticket"), selectedImage: UIImage(systemName: "ticket"))
        let configurationViewController =  ConfigurationViewController()
        configurationViewController.tabBarItem = UITabBarItem(title: "Configuration", image: UIImage(systemName: "gear.circle"), selectedImage: UIImage(systemName: "gear.circle"))
        self.setViewControllers([ showViewController,configurationViewController], animated: false)
    }
}
