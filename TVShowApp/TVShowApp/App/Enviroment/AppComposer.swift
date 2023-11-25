//
//  AppComposer.swift
//  TVShowApp
//
//  Created by Jastin on 20/11/23.
//

import UIKit
import PresentationLayer

final public class AppComposer {
    
    public let window: UIWindow
    public let biometricManager: BiometricManager
    
    public required init(window: UIWindow, biometricManager: BiometricManager) {
        self.window = window
        self.biometricManager = biometricManager
    }
    
    public func setUpApp() {
        let showViewModel = ShowDependencyInjection.setShowViewModelDependecy()
        let showTableViewController = getShowTableViewController(showViewModelActions: showViewModel)
        let configurationViewController = getConfigurationViewController()
        let mainTabBarViewController = MainTabBarViewController(viewControllers: [showTableViewController, configurationViewController])
        let deniedViewController = DeniedAccessViewController()
        setRootViewController(mainTabBarViewController, deniedViewController)
    }
    
    private func setRootViewController(_ mainTabBarViewController: MainTabBarViewController,
                                       _ deniedViewController: DeniedAccessViewController) {
        if biometricManager.isAuthRequired {
            biometricManager.verify { [setRootViewControllerFor] state in
                if state {
                    setRootViewControllerFor(mainTabBarViewController)
                } else {
                    setRootViewControllerFor(deniedViewController)
                }
            } whenFailure: { [setRootViewControllerFor] in
                setRootViewControllerFor(deniedViewController)
            }
        } else {
            setRootViewControllerFor(mainTabBarViewController)
        }
    }
    
    private func setRootViewControllerFor(_ vc: UIViewController) {
        self.window.rootViewController = vc
        self.window.makeKeyAndVisible()
    }
    
    public func getShowTableViewController(showViewModelActions: ShowViewModelActions) -> UINavigationController {
        let navController = UINavigationController()
        let showTableViewController =  ShowTableViewController(showViewModelAction: showViewModelActions,
                                                               didSelectShow: { index in
            let showEntity = showViewModelActions.showEntities[index]
            let showEpisodeViewModel = ShowEpisodeDependeyInjection.setShowEpisodeViewModelDependecy()
            let showDetailViewController = ShowDetailViewController(showEntity: showEntity,
                                                                    showEpisodeViewModel: showEpisodeViewModel)
            navController.pushViewController(showDetailViewController, animated: true)
        })
        navController.setViewControllers([showTableViewController], animated: true)
        navController.navigationBar.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)!
        navController.tabBarItem = setTabBarWith(title: "TV Shows",
                                                 image: "ticket",
                                                 selectedImage:  "ticket")
        return navController
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
