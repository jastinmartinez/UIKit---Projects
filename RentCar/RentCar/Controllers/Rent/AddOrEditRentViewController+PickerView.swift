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
                if let isViewOnly = isViewOnly{
                    if isViewOnly {
                        return vehiclePresenter!._vehicles.count
                    }
                    else {
                        return vehiclePresenter!.vehicles.count
                    }
                    
                }else {
                    return vehiclePresenter!.vehicles.count
                }
            }
        }
        if pickerView is RentEmployeePickerVIew {
            if employeePresenter!.employees.count > 0 {
                if let isViewOnly = isViewOnly{
                    if isViewOnly {
                        return employeePresenter!._employees.count
                    }
                    else {
                        return employeePresenter!.employees.count
                    }
                }else {
                    return employeePresenter!.employees.count
                }
            }
        }
        if pickerView is RentCustomerPickerView {
            if customerPresenter!.customers.count > 0 {
                if let isViewOnly = isViewOnly{
                    if isViewOnly {
                        return customerPresenter!._customers.count
                    }
                    else {
                        return customerPresenter!.customers.count
                    }
                }else {
                    return customerPresenter!.customers.count
                }
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
            
            if let isViewOnly = isViewOnly{
                if isViewOnly {
                    return vehiclePresenter?._vehicles[row].description
                }
                else {
                    return vehiclePresenter?.vehicles[row].description
                }
            }else {
                return vehiclePresenter?.vehicles[row].description
            }
            
            
        }
        if pickerView is RentEmployeePickerVIew {
            if let isViewOnly = isViewOnly{
                if isViewOnly {
                    return employeePresenter?._employees[row].name
                }
                else {
                    return employeePresenter?.employees[row].name
                }
            }else {
                return employeePresenter?.employees[row].name
            }
            
        }
        if pickerView is RentCustomerPickerView {
            if let isViewOnly = isViewOnly{
                if isViewOnly {
                    return customerPresenter?._customers[row].name
                }
                else {
                    return customerPresenter?.customers[row].name
                }
            }else {
                return customerPresenter?.customers[row].name
            }
        }
        return nil
    }
}
