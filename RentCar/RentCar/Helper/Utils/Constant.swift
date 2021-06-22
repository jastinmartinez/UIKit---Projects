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
        static let employeeValidation =  "\(employee)/validation"
        static let vehicle =  "\(baseUrl)/vehicle"
        static let vehicleValidation =  "\(vehicle)/validation"
    }
    
    struct storyBoardId {
        static let appTabBarViewController = "AppTabBarViewController"
        static let authenticationViewController = "authenticationViewController"
    }
    
    struct segue {
        static let managementSegue = "managementSegue"
        static let maintenanceSegue = "maintenanceSegue"
        static let maintenanceModifySegue = "maintenanceModifySegue"
        static let customerSegue = "customerSegue"
        static let employeeSegue = "employeeSegue"
        static let vehicleSegue = "vehicleSegue"
        static let addOrEditVehicleSegue = "addOrEditVehicleSegue"
        static let addOrEditCustomerSegue = "addOrEditCustomerSegue"
        static let addOrEditEmployeeSegue = "addOrEditEmployeeSegue"
    }
    
    struct reusableView {
        static let homeCollectionReusableView = "homeCollectionReusableView"
        static let managementReusableView = "ManagementReusableView"
    }
    
    struct tableViewCell {
        static let maintenanceTypeTableViewCell = "maintenanceTableViewCell"
        static let customerTableViewCell = "customerTableViewCell"
        static let employeeTableViewCell = "employeeTableViewCell"
        static let vehicleTableViewCell = "vehicleTableViewCell"
    }
}

