//
//  MainTabBarViewController.swift
//  TVShowApp
//
//  Created by Jastin on 1/4/22.
//

import UIKit
import PresentationLayer

class MainTabBarViewController: UITabBarController {

    convenience init(viewControllers: [UIViewController]) {
        self.init()
        self.setViewControllers(viewControllers, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewConfiguration()
        self.setViewControlellers()
    }
    
    fileprivate func setViewConfiguration() {
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor(named: ColorHelper.red.rawValue)!
        self.view.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)!
    }
    
    fileprivate func setViewControlellers() {
        let showViewModel = ShowDependencyInjection.setShowViewModelDependecy()
        let showEpisodeViewModel = ShowEpisodeDependeyInjection.setShowEpisodeViewModelDependecy()
        
        let showViewController = UINavigationController(rootViewController: ShowTableViewController(showViewModel: showViewModel, showEpisodeViewModel: showEpisodeViewModel))
        showViewController.navigationBar.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)!
        showViewController.tabBarItem = UITabBarItem(title: "TV Shows", image: UIImage(systemName: "ticket"), selectedImage: UIImage(systemName: "ticket"))
        
        let configurationViewController =  ConfigurationViewController()
        configurationViewController.tabBarItem = UITabBarItem(title: "Configuration", image: UIImage(systemName: "gear.circle"), selectedImage: UIImage(systemName: "gear.circle"))
        
        self.setViewControllers([ showViewController,configurationViewController], animated: false)
    }
}
