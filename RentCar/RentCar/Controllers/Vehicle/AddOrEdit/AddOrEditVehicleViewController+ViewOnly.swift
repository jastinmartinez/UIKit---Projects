//
//  AddOrEditVehicleViewController+VisualizerMode.swift
//  RentCar
//
//  Created by Jastin on 21/6/21.
//

import Foundation


extension AddOrEditVehicleViewController {
    
    func initViewOnly() {
        
        if let isViewOnly = isViewOnly, let vehicle = vehicle {
            
            if isViewOnly {
                
                self.title = "Visualizar"
                
                vehicleModelToOutlets(vehicle)
                
                EnableOrDisableOutlets().textField(textfield: vehicleDescriptionTextField)
                EnableOrDisableOutlets().textField(textfield: vehicleEngineNumberTextField)
                EnableOrDisableOutlets().textField(textfield: vehiclePlateTextField)
                EnableOrDisableOutlets().textField(textfield: vehicleChasisNumberTextField)
                
                EnableOrDisableOutlets().pickerView(pickerView: vehicleVehicleTypePickerView)
                EnableOrDisableOutlets().pickerView(pickerView: vehicleVehicleMarkPickerView)
                EnableOrDisableOutlets().pickerView(pickerView: vehicleVehicleModelPickerView)
                EnableOrDisableOutlets().pickerView(pickerView: vehicleCombustibleTypePickerView)
                
                EnableOrDisableOutlets().button(button: vehicleSaveButton)
                EnableOrDisableOutlets().switchs(switchs: vehicleStateSwitch,isEnabled: false)
                
            }
        }
    }
}
