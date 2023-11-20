//
//  MainTabBarViewController.swift
//  TVShowApp
//
//  Created by Jastin on 1/4/22.
//

import UIKit
import PresentationLayer

public class MainTabBarViewController: UITabBarController {

    public required convenience init(viewControllers: [UIViewController]) {
        self.init()
        self.setViewControllers(viewControllers, animated: true)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewConfiguration()
    }
    
    fileprivate func setViewConfiguration() {
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor(named: ColorHelper.red.rawValue)!
        self.view.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)!
    }
}
