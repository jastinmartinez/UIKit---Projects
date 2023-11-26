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
    
    private var showNavigationController: UINavigationController!
    private var showTableViewController: ShowTableViewController!
    private var configurationViewController: ConfigurationViewController!
    private var deniedViewController: DeniedAccessViewController!
    private var mainTabBarViewController: MainTabBarViewController!
    
    public required init(window: UIWindow, biometricManager: BiometricManager) {
        self.window = window
        self.biometricManager = biometricManager
        onCreate()
    }
    
    private func onCreate() {
        showTableViewController = getShowTableViewController(showViewModelActions:  ShowDependencyInjection.setShowViewModelDependency())
        showNavigationController = getShowNavigationController(rootViewController: showTableViewController)
        configurationViewController = getConfigurationViewController()
        deniedViewController = getDeniedViewController()
        mainTabBarViewController = getMainTabBar(viewControllers: [showNavigationController, configurationViewController])
    }
    
    public func setUpApp() {
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
    
    private func getDeniedViewController() -> DeniedAccessViewController {
        return DeniedAccessViewController()
    }
    
    private func getMainTabBar(viewControllers: [UIViewController]) -> MainTabBarViewController {
        return MainTabBarViewController(viewControllers: viewControllers)
    }
    
    public func getShowNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)!
        navController.tabBarItem = setTabBarWith(title: "TV Shows",
                                                 image: "ticket",
                                                 selectedImage:  "ticket")
        return navController
    }
    
    public func getShowTableViewController(showViewModelActions: ShowViewModelActions) -> ShowTableViewController  {
        let showTableViewController = ShowTableViewController(showViewModelAction: showViewModelActions)
        showTableViewController.didSelectShow = { [showNavigationController] index in
            let showEntity = showViewModelActions.showEntities[index]
            let showEpisodeViewModel = ShowEpisodeDependencyInjection.setShowEpisodeViewModelDependency()
            let showDetailViewController = ShowDetailViewController(showEntity: showEntity,
                                                                    showEpisodeViewModel: showEpisodeViewModel)
            showNavigationController?.pushViewController(showDetailViewController, animated: true)}
        return showTableViewController
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
