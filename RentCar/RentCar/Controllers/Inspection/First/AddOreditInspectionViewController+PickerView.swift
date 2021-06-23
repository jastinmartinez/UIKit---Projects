//
//  AddOreditInspectionViewController+PickerView.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import Foundation
import UIKit

extension AddOrEditInspectionViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView is InspectionCustomerPickerView {
            
            if customerPresenter!.customers.count > 0 {
                
                self.customerID =  customerPresenter?.customers[row].id
            }
            
        } else  if pickerView is InspectionVehiclePickerView {
            
            if vehiclePresenter!.vehicles.count > 0 {
                
                self.vehicleID = vehiclePresenter?.vehicles[row].id
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
        if pickerView is InspectionCustomerPickerView {
            
            return customerPresenter!.customers.count
            
        } else  if pickerView is InspectionVehiclePickerView {
            
            return vehiclePresenter!.vehicles.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        if pickerView is InspectionCustomerPickerView {
           
            return customerPresenter!.customers[row].name
            
        } else  if pickerView is InspectionVehiclePickerView {
            
            return vehiclePresenter!.vehicles[row].description
        }
        
        return nil
    }
}
