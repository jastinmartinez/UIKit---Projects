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
    }
}
