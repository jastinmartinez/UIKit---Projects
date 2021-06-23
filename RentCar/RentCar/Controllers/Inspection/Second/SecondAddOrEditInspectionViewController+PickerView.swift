//
//  SecondAddOrEditInspectionViewController+PickerView.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import Foundation
import UIKit
extension SecondAddOrEditInspetionViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
        return employeePresenter!.employees.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if employeePresenter!.employees.count > 0 {
            
            self.employeeID = employeePresenter?.employees[row].id
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return employeePresenter?.employees[row].name
    }
}
