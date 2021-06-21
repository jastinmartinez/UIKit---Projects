//
//  AddOrEditVehicleViewController+VehicleMarkPickerView.swift
//  RentCar
//
//  Created by Jastin on 20/6/21.
//

import Foundation
import UIKit

extension AddOrEditVehicleViewController: UIPickerViewDataSource,UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView is CombustibleTypePickerView {
            
            return combustibleTypePresenter.combustibleTypes.count
        }
        else if pickerView is VehicleMarkPickerView {
            
            return vehicleMarkPresenter.vehicleMarks.count
        }
        else if pickerView is VehicleTypePickerView {
            
            return vehicleTypePresenter.vehicleTypes.count
        }
        else if pickerView is VehicleModelPickerView {
            
            return vehicleModelPresenter.vehicleModels.count
        }
        else {
            
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView is VehicleMarkPickerView {
        
            vehicleModelPresenter.getModelsOfMarks(vehicleMarkPresenter.vehicleMarks[row])
            
            self.vehicleVehicleModelPickerView.reloadAllComponents()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        if pickerView is CombustibleTypePickerView {
            
            return combustibleTypePresenter.combustibleTypes[row].description
        }
        else if pickerView is VehicleMarkPickerView {
        
            return vehicleMarkPresenter.vehicleMarks[row].description
        }
        else if pickerView is VehicleTypePickerView {
            
            return vehicleTypePresenter.vehicleTypes[row].description
        }
        else if pickerView is VehicleModelPickerView {
            
            return vehicleModelPresenter.vehicleModels[row].description
        }
        else {
            
            return nil
        }
    }
}
