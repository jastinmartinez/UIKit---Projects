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
        static let vechileMark =  "\(baseUrl)/vehiclemark"
        static let vehicleModel =  "\(baseUrl)/vehiclemodel"
        static let vehicleType =  "\(baseUrl)/vehicletype"
        static let customer =  "\(baseUrl)/customer"
        static let customerValidation =  "\(customer)/validation"
        static let employee =  "\(baseUrl)/employee"
    }
    
    struct storyBoardId {
        static let appTabBarViewController = "AppTabBarViewController"
    }
    
    struct segue {
        static let maintenanceSegue = "maintenanceSegue"
        static let maintenanceModifySegue = "maintenanceModifySegue"
        static let customerSegue = "customerSegue"
        static let addOrEditCustomerSegue = "addOrEditCustomerSegue"
    }
    
    struct reusableView {
        static let homeCollectionReusableView = "homeCollectionReusableView"
        static let managementReusableView = "ManagementReusableView"
    }
    
    struct tableViewCell {
        static let maintenanceTypeTableViewCell = "maintenanceTableViewCell"
        static let customerTableViewCell = "customerTableViewCell"
    }
}

