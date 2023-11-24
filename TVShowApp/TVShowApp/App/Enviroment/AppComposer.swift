//
//  AppComposer.swift
//  TVShowApp
//
//  Created by Jastin on 20/11/23.
//

import UIKit
import LocalAuthentication

final public class BiometricManager {
    private let context: LAContext
    private let localStorer: LocalStorer
    
    public init(context: LAContext = .init(),
                localStorer: LocalStorer) {
        self.context = context
        self.localStorer = localStorer
    }
    
    public var isAuthRequired: Bool {
        return localStorer.get(for: .biometric)
    }
    
    public func verify(whenSuccess: ((Bool) -> Void)?,
                       whenFailure: (() -> Void)?) {
        Biometric.context(context).verify { verification in
            switch verification {
            case .success(let state):
                whenSuccess?(state)
            case .failure:
                whenFailure?()
            }
        }
    }
}

final public class AppComposer {
    
    public let window: UIWindow
    public let biometricManager: BiometricManager
    
    public required init(window: UIWindow, biometricManager: BiometricManager) {
        self.window = window
        self.biometricManager = biometricManager
    }
    
    public func setUpApp() {
        let showTableViewController = getShowTableViewController()
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
    
    private func getShowTableViewController() -> UINavigationController {
        let showViewModel = ShowDependencyInjection.setShowViewModelDependecy()
        let showEpisodeViewModel = ShowEpisodeDependeyInjection.setShowEpisodeViewModelDependecy()
        
        let showViewController = UINavigationController(rootViewController: ShowTableViewController(showViewModelInteraction: showViewModel,
                                                                                                    showEpisodeViewModel: showEpisodeViewModel))
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
