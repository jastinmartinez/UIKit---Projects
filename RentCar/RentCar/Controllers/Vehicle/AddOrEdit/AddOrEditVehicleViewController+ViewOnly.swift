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
                
                vehicleModelToTextField(vehicle)
                
                EnableOutlets().textField(textfield: vehicleDescriptionTextField)
                EnableOutlets().textField(textfield: vehicleEngineNumberTextField)
                EnableOutlets().textField(textfield: vehiclePlateTextField)
                EnableOutlets().textField(textfield: vehicleChasisNumberTextField)
                
                EnableOutlets().pickerView(pickerView: vehicleVehicleTypePickerView)
                EnableOutlets().pickerView(pickerView: vehicleVehicleMarkPickerView)
                EnableOutlets().pickerView(pickerView: vehicleVehicleModelPickerView)
                EnableOutlets().pickerView(pickerView: vehicleCombustibleTypePickerView)
                
                EnableOutlets().button(button: vehicleSaveButton)
                EnableOutlets().switchs(switchs: vehicleStateSwitch)
            }
        }
    }
}
