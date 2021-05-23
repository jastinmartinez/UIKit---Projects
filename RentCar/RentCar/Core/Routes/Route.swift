//
//  Route.swift
//  RentCar
//
//  Created by Jastin on 22/5/21.
//

import Foundation
import UIKit

final class Routes {
    
    private let homeviewController = "HomeViewController"
    
    private let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    func name(routeName: ViewControllerNames) -> UIViewController?  {
        
        switch routeName {
        
        case .HomeViewController:
            return storyBoard.instantiateViewController(withIdentifier: homeviewController) as! HomeViewController
        }
    }
}

enum ViewControllerNames {
    
    case HomeViewController
}


