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
        static let rent =  "\(baseUrl)/rent"
        static let devolution =  "\(baseUrl)/devolution"
        static let inspection =  "\(baseUrl)/inspection"
    }
    
    struct storyBoardId {
        static let appTabBarViewController = "AppTabBarViewController"
        static let authenticationViewController = "authenticationViewController"
    }
    
    struct segue {
        
        static let rentSegue = "rentSegue"
        static let addOrEditRentSegue = "addOrEditRentSegue"
        static let secondeAddOrEditRentSegue = "secondAddOrEditRentSegue"
        static let devolutionSegue = "devolutionSegue"
        static let addOrEditDevolutionSegue = "addOrEditDevolutionSegue"
        static let secondeAddOrEditDevolutionSegue = "secondeAddOrEditDevolutionSegue"
        static let managementSegue = "managementSegue"
        static let maintenanceSegue = "maintenanceSegue"
        static let maintenanceModifySegue = "maintenanceModifySegue"
        static let customerSegue = "customerSegue"
        static let employeeSegue = "employeeSegue"
        static let vehicleSegue = "vehicleSegue"
        static let inspectionSegue = "inspectionSegue"
        static let addOrEditInspectionSegue = "addOrEditInspectionSegue"
        static let secondAddOrEditVehicleSegue = "secondAddOrEditVehicleSegue"
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
        static let inspectionTableViewCell = "inspectionTableViewCell"
        static let rentTableViewCell = "rentTableViewCell"
        static let devolutionTableViewCell = "devolutionTableViewCell"
    }
}

