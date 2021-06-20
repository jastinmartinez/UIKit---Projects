//
//  AddOrEditViewController+Validations.swift
//  RentCar
//
//  Created by Jastin on 15/6/21.
//

import Foundation
import UIKit

extension AddOrEditEmployeeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField is EmployeeIDTextField {
            
           return  CharacterSet(charactersIn: "1234567890").isSuperset(of: CharacterSet(charactersIn: string)) && range.location <= 10
        }
        
        if textField is EmployeeCommisionPercentTextField {
        
            return  CharacterSet(charactersIn: "1234567890").isSuperset(of: CharacterSet(charactersIn: string)) && range.location <= 1
        }
        
        return true
    }
    
    @objc private func employeeID(_ textField: UITextField) {
        
        if textField.text!.isEmpty {
            EnableValidationLabels().enable(label: employeeIDErrorLabel, message: "Digitar Cedula")
        }
        else if (!UserDocumentId().verify(textField.text!)) {
            EnableValidationLabels().enable(label: employeeIDErrorLabel, message: "Cedula Invalida" )
        }
        else {
            EnableValidationLabels().enable(label: employeeIDErrorLabel,setHidden: true)
        }
    }
    
    @objc private func employeeName(_ textField: UITextField) {
        
        if textField.text!.isEmpty {
            EnableValidationLabels().enable(label: employeeNameErrorLabel, message: "Digitar Nombre")
        }
        else {
            EnableValidationLabels().enable(label: employeeNameErrorLabel,setHidden: true)
        }
    }
    
    @objc private func employeeComissionPercent(_ textField: UITextField) {
        
        if textField.text!.isEmpty {
            EnableValidationLabels().enable(label: employeeCommisionPercentErrorLabel, message: "Digitar Comision")
        }
        else {
            EnableValidationLabels().enable(label: employeeCommisionPercentErrorLabel,setHidden: true)
        }
    }
    
    
    func isInputValidationComplete(completion: (Bool) -> ()) {
        
        if let id = employeeIDErrorLabel.text, let name = employeeNameErrorLabel.text,let comissionPercent = employeeCommisionPercentErrorLabel.text  {
            completion( id.isEmpty && name.isEmpty && comissionPercent.isEmpty && !employeeIDTextField.text!.isEmpty && !employeeNameTextField.text!.isEmpty && !employeeCommisionPercentTextField.text!.isEmpty)
        }
    }
    
    func initOutletsValidationEvent() {
        self.employeeIDTextField.delegate = self
        self.employeeCommisionPercentTextField.delegate = self
        self.employeeIDTextField.addTarget(self, action: #selector(employeeID), for: .editingChanged)
        self.employeeNameTextField.addTarget(self, action: #selector(employeeName), for: .editingChanged)
        self.employeeCommisionPercentTextField.addTarget(self, action: #selector(employeeComissionPercent), for: .editingChanged)
    }
}
