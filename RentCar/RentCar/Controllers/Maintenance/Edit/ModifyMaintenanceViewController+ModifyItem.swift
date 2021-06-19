//
//  MaintenanceModifyViewController+ModifyItem.swift
//  RentCar
//
//  Created by Jastin on 6/6/21.
//

import Foundation
import UIKit

extension ModifyMaintenanceViewController {
    
    func modifyItem()  {
        
        if presenterType is CombustibleTypePresenter {
            
            let combustibleTypePresenter: CombustibleTypePresenter = presenterType as! CombustibleTypePresenter
            combustibleTypePresenter.update(CombustibleType(id: (modelType as! CombustibleType).id, description: modifiedMaintenanceDescriptionTextField.text!, state: modifiedMaintenanceStateSwitch.isOn))
            
        } else if presenterType is VehicleMarkPresenter {
    
            let vehicleMarkerPresenter: VehicleMarkPresenter = presenterType as! VehicleMarkPresenter
            vehicleMarkerPresenter.update(VehicleMark(id: (modelType as! VehicleMark).id, description: modifiedMaintenanceDescriptionTextField.text!, state: modifiedMaintenanceStateSwitch.isOn))
        }
        
        else if presenterType is VehicleTypePresenter {
    
            let vehicleTypePresenter: VehicleTypePresenter = presenterType as! VehicleTypePresenter
            vehicleTypePresenter.update(VehicleType(id: (modelType as! VehicleType).id, description: modifiedMaintenanceDescriptionTextField.text!, state: modifiedMaintenanceStateSwitch.isOn))
        }
        else if presenterType is VehicleModelPresenter {
    
            let vehicleModelPresenter: VehicleModelPresenter = presenterType as! VehicleModelPresenter
            vehicleModelPresenter.update(VehicleModel(id: (modelType as! VehicleModel).id, description: modifiedMaintenanceDescriptionTextField.text!, vehicleMark: (modelType as! VehicleModel).vehicleMark, state: modifiedMaintenanceStateSwitch.isOn))
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
