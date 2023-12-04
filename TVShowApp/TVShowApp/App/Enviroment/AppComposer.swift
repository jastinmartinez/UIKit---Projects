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
    public private(set) var showNavigationController: UINavigationController!
    public private(set) var showTableViewController: ShowTableViewController!
    private var configurationViewController: ConfigurationViewController!
    private var deniedViewController: DeniedAccessViewController!
    private var mainTabBarViewController: MainTabBarViewController!
    
    public required init(window: UIWindow,
                         biometricManager: BiometricManager) {
        self.window = window
        self.biometricManager = biometricManager
        self.onInit(showViewModelActions: ShowDependencyInjection.setShowViewModelDependency())
    }
    
    public convenience init(window: UIWindow,
                            biometricManager: BiometricManager,
                            showViewModelActions: ShowViewModelActions) {
        self.init(window: window, biometricManager: biometricManager)
        self.onInit(showViewModelActions: showViewModelActions)
    }
    
    private func onInit(showViewModelActions: ShowViewModelActions) {
        showTableViewController = getShowTableViewController(showViewModelActions:  showViewModelActions)
        showNavigationController = getShowNavigationController(rootViewController: showTableViewController)
        setDidSelectShow(showViewModelActions: showViewModelActions)
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
    
    private func getShowNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)!
        navController.tabBarItem = setTabBarWith(title: "TV Shows",
                                                 image: "ticket",
                                                 selectedImage:  "ticket")
        return navController
    }
    
    private func getShowTableViewController(showViewModelActions: ShowViewModelActions) -> ShowTableViewController  {
      return ShowTableViewController(showViewModelAction: showViewModelActions)
    }
    
    private func setDidSelectShow(showViewModelActions: ShowViewModelActions) {
        showTableViewController.didSelectShow = {  [weak showNavigationController] index in
            let showEntity = showViewModelActions.shows[index]
            let showEpisodeViewModel = ShowEpisodeDependencyInjection.setShowEpisodeViewModelDependency()
            let showDetailViewController = ShowDetailViewController(showEntity: showEntity, showEpisodeViewModel: showEpisodeViewModel)
            showNavigationController?.pushViewController(showDetailViewController, animated: true)
        }
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
