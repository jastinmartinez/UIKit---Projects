//
//  AddOrEditVehicleViewController+Validation.swift
//  RentCar
//
//  Created by Jastin on 20/6/21.
//

import Foundation
import UIKit

extension AddOrEditVehicleViewController: UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField is VehiclePlateTextField {
         
            return range.location <= 11
            
        } else if textField is VehicleChasisNumberTextField ||  textField is VehicleEngineNumberTextField{
            
            return range.location <= 16
        }
        
        return true
    }
    
    @objc private func vehicleDescription(_ textField: UITextField) {
    
        if textField.text!.isEmpty {
           
            EnableValidationLabels().enable(label: vehicleDescriptionErrorLabel,message: "Digitar Descripcion")
        }
        else {
            
            EnableValidationLabels().enable(label: vehicleDescriptionErrorLabel,setHidden: true)
        }
    }
    
    @objc private func vehicleEngineNumber(_ textField: UITextField) {
       
        if textField.text!.isEmpty {
            
            EnableValidationLabels().enable(label: vehicleEngineNumberErrorLabel,message: "Digitar Numero Motor")
        }
        else {
            
            EnableValidationLabels().enable(label: vehicleEngineNumberErrorLabel,setHidden: true)
        }
    }
    
    @objc private func vehicleChasisNumber(_ textField: UITextField) {
        
        if textField.text!.isEmpty {
            
            EnableValidationLabels().enable(label: vehicleChasisNumberErrorLabel,message: "Digitar Numero Chasis")
        }
        else {
            
            EnableValidationLabels().enable(label: vehicleChasisNumberErrorLabel,setHidden: true)
        }
    }
    
    @objc private func vehiclePlate(_ textField: UITextField) {
        
        if textField.text!.isEmpty {
            
            EnableValidationLabels().enable(label: vehiclePlateErroLabel,message: "Digitar Placa")
        }
        else {
            
            EnableValidationLabels().enable(label: vehiclePlateErroLabel,setHidden: true)
        }
    }
    
    func isInputValidationComplete(completion: (Bool) -> ()) {
        
        if let engineNumber = vehicleEngineNumberErrorLabel.text, let chasisNumber = vehicleChasisNumberErrorLabel.text, let vehiclePlate = vehiclePlateTextField.text  {
            completion( engineNumber.isEmpty && chasisNumber.isEmpty && vehiclePlate.isEmpty && !vehicleEngineNumberTextField.text!.isEmpty && !vehicleChasisNumberTextField.text!.isEmpty && !vehiclePlateTextField.text!.isEmpty
                            && (vehicleTypeID != nil)
                            && (vehicleModelID != nil)
                            && (vehicleMarkID != nil)
                            && (combustibleTypeID != nil)
            )
        }
    }
    
    func initValidation() {
        
        self.vehicleDescriptionTextField.addTarget(self, action: #selector(vehicleDescription), for: .editingChanged)
        
        self.vehicleEngineNumberTextField.addTarget(self, action: #selector(vehicleEngineNumber), for: .editingChanged)
        
        self.vehicleChasisNumberTextField.addTarget(self, action: #selector(vehicleChasisNumber), for: .editingChanged)
        
        self.vehiclePlateTextField.addTarget(self, action: #selector(vehiclePlate), for: .editingChanged)
    }
}
