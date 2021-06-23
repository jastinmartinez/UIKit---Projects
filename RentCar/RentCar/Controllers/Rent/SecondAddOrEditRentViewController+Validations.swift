//
//  SecondAddOrEditRentViewController+Validations.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import Foundation

import UIKit

extension SecondAddOrEditRentViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        if textField is RentAmoufOfDayTextField {
            
           return  CharacterSet(charactersIn: "1234567890").isSuperset(of: CharacterSet(charactersIn: string)) && range.location <= 2
        }
        
        if textField is RentAmountPerDayTextField {
        
            return  CharacterSet(charactersIn: "1234567890.").isSuperset(of: CharacterSet(charactersIn: string)) && range.location <= 5
        }
        
        return true
    }
    
    @objc private func amountPerDay(_ textfield: UITextField) {
        if textfield.text!.isEmpty {
            EnableOrDisableOutlets().label(label: rentAmountPerDayErrorLabel, message: "Digitar Monto Por Dia")
        }
        else {
            EnableOrDisableOutlets().label(label: rentAmountPerDayErrorLabel,setHidden: true)
            calculate()
        }
    }
    
    @objc private func amountOfDay(_ textfield: UITextField) {
        if textfield.text!.isEmpty {
            EnableOrDisableOutlets().label(label: rentAmountOfDayErrorLabel, message: "Digitar Cantidad De Dias")
        }
        else {
            EnableOrDisableOutlets().label(label: rentAmountOfDayErrorLabel,setHidden: true)
            calculate()
        }
    }
    func calculate() {
        
        if let text1 = rentAmountPerDayTextField.text, let text2 = rentAmountOfDaysTextField.text {
            if !text1.isEmpty && !text2.isEmpty {
                rentTotalTextField.text = "$\((Double.init(text1)!  * Double.init(text2)!).ToString())"
            }
        }
    }
    
    func initValidation() {
        self.rentDatePickerDate.minimumDate = Date()
        self.rentAmountPerDayTextField.addTarget(self, action: #selector(amountPerDay), for: .editingChanged)
        self.rentAmountOfDaysTextField.addTarget(self, action: #selector(amountOfDay), for: .editingChanged)
    }
}
