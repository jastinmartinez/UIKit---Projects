//
//  AddOrEditRentViewController+PickerView.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import Foundation
import UIKit

extension AddOrEditRentViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView is RentVehiclePickerView {
            if vehiclePresenter!.vehicles.count > 0 {
                return vehiclePresenter!.vehicles.count
            }
        }
        if pickerView is RentEmployeePickerVIew {
            if employeePresenter!.employees.count > 0 {
                return employeePresenter!.employees.count
            }
        }
        if pickerView is RentCustomerPickerView {
            if customerPresenter!.customers.count > 0 {
                return customerPresenter!.customers.count
            }
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView is RentVehiclePickerView {
            if vehiclePresenter!.vehicles.count > 0 {
                self.vehicleID =  vehiclePresenter!.vehicles[row].id
            }
        }
        if pickerView is RentEmployeePickerVIew {
            if employeePresenter!.employees.count > 0 {
                self.employeeID = employeePresenter!.employees[row].id
            }
        }
        if pickerView is RentCustomerPickerView {
            if customerPresenter!.customers.count > 0 {
                self.customerID = customerPresenter!.customers[row].id
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView is RentVehiclePickerView {
            
            return vehiclePresenter?.vehicles[row].description
            
        }
        if pickerView is RentEmployeePickerVIew {
          
            return employeePresenter?.employees[row].name
            
        }
        if pickerView is RentCustomerPickerView {
        
            return customerPresenter?.customers[row].name
            
        }
        return nil
    }
}
