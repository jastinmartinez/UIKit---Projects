//
//  AppComposer.swift
//  TVShowApp
//
//  Created by Jastin on 20/11/23.
//

import UIKit


final public class AppComposer {
    
    public let window: UIWindow
    
    public required init(window: UIWindow) {
        self.window = window
    }
    
    public func setUpApp() {
        let showTableViewController = getShowTableViewController()
        let configurationViewController = getConfigurationViewController()
        let mainTabBarViewController = MainTabBarViewController(viewControllers: [showTableViewController, configurationViewController])
        setRootViewControllerFor(mainTabBarViewController)
    }
    
    private func setRootViewControllerFor(_ vc: UIViewController) {
        self.window.rootViewController = vc
        self.window.makeKeyAndVisible()
    }
    
    private func getShowTableViewController() -> UINavigationController {
        let showViewModel = ShowDependencyInjection.setShowViewModelDependecy()
        let showEpisodeViewModel = ShowEpisodeDependeyInjection.setShowEpisodeViewModelDependecy()
        
        let showViewController = UINavigationController(rootViewController: ShowTableViewController(showViewModel: showViewModel, showEpisodeViewModel: showEpisodeViewModel))
        showViewController.navigationBar.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)!
        showViewController.tabBarItem = setTabBarWith(title: "TV Shows",
                                                      image: "ticket",
                                                      selectedImage:  "ticket")
        return showViewController
        
    }
    
    private func getConfigurationViewController() -> ConfigurationViewController {
        let configurationViewController =  ConfigurationViewController()
        configurationViewController.tabBarItem = setTabBarWith(title: "Configuration",
                                                               image:  "gear.circle",
                                                               selectedImage: "gear.circle")
        return configurationViewController
    }
    
    private func setTabBarWith(title: String, image: String, selectedImage: String) -> UITabBarItem {
        return UITabBarItem(title: title,
                            image: UIImage(systemName: image),
                            selectedImage: UIImage(systemName: selectedImage))
    }
}
