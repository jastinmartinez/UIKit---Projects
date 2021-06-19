//
//  MaintenanceModifyViewController+DidItemSelected.swift
//  RentCar
//
//  Created by Jastin on 6/6/21.
//

import Foundation

extension ModifyMaintenanceViewController {
    
    func didItemSelected(_ vm: ModelType) {
        
        if vm is CombustibleType {
            
            let combustibleType: CombustibleType = vm as! CombustibleType
            self.modifiedMaintenanceDescriptionTextField.text = combustibleType.description
            self.modifiedMaintenanceStateSwitch.isOn = combustibleType.state
            
        }
        else if vm is VehicleMark {
            
            let vehicleMark: VehicleMark = vm as! VehicleMark
            self.modifiedMaintenanceDescriptionTextField.text = vehicleMark.description
            self.modifiedMaintenanceStateSwitch.isOn = vehicleMark.state
            
        }
        
        else if vm is VehicleType {
            
            let vehicleType: VehicleType = vm as! VehicleType
            self.modifiedMaintenanceDescriptionTextField.text = vehicleType.description
            self.modifiedMaintenanceStateSwitch.isOn = vehicleType.state
            
        }
        
        else if vm is VehicleModel {
            
            let vehicleModel: VehicleModel = vm as! VehicleModel
            self.modifiedMaintenanceDescriptionTextField.text = vehicleModel.description
            self.modifiedMaintenanceStateSwitch.isOn = vehicleModel.state
            
        }
        
    }
}
