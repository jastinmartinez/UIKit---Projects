//
//  Constant.swift
//  RentCar
//
//  Created by Jastin on 17/5/21.
//

import Foundation



struct Constant {
    
    struct uRL {
        private static let baseUrl =  "http://127.0.0.1:8080"
        static let signIn =  "\(baseUrl)/signin"
        static let signUp =  "\(baseUrl)/signup"
        static let combustibleType =  "\(baseUrl)/combustibletype"
    }
    
    struct storyBoardId {
        static let appTabBarViewController = "AppTabBarViewController"
    }
    
    struct segue {
        static let combustibleTypeSegue = "combustibleTypeSegue"
        static let modifyCombustibleTypeSegue = "modifyCombustibleTypeSegue"
    }
    
    struct reusableView {
        static let managementReusableView = "ManagementReusableView"
    }
    
    struct tableViewCell {
        static let combustibleTypeTableViewCell = "combustibleTypeTableViewCell"
    }
}

