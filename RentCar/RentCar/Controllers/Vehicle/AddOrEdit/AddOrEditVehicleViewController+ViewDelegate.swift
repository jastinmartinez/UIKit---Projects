//
//  AddOrEditVehicleViewController+View.swift
//  RentCar
//
//  Created by Jastin on 20/6/21.
//

import Foundation

extension AddOrEditVehicleViewController: MaintenanceViewDelegateProtocol {
    
    func didArrayChange() {
        
        self.vehicleVehicleTypePickerView.reloadAllComponents()
        
        self.vehicleVehicleMarkPickerView.reloadAllComponents()
        
        self.vehicleCombustibleTypePickerView.reloadAllComponents()
        
        
//        Set Default value to bindinf variables
        
        if vehicleMarkPresenter.vehicleMarks.count > 0 {
            
            self.vehicleMarkID =  self.vehicleMarkPresenter.vehicleMarks[0].id
        }
        
        if vehicleTypePresenter.vehicleTypes.count > 0 {
            
            self.vehicleTypeID = vehicleTypePresenter.vehicleTypes[0].id
        }
        
        if combustibleTypePresenter.combustibleTypes.count > 0 {
            
            self.combustibleTypeID = combustibleTypePresenter.combustibleTypes[0].id
        }
    }
}
