//
//  SecondAddOrEditInspectionViewController+AddOnly.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import Foundation
import UIKit

extension SecondAddOrEditInspetionViewController {
    func initAddOnly() {
        inspectionDate = inspectionDateDatePicker.date
        
        self.inspectionEmployeePickerView.reloadAllComponents()
        
        if inspectionEmployeePickerView.numberOfComponents > 0 {
            
            self.employeeID = self.employeePresenter?.employees.first?.id
        }
    }
}
