//
//  CustomerViewController+TextFieldValidation.swift
//  RentCar
//
//  Created by Jastin on 8/6/21.
//

import Foundation
import UIKit
import CreditCardValidator



extension AddOrEditCustomerViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return CharacterSet(charactersIn: "1234567890").isSuperset(of: CharacterSet(charactersIn: string))
    }
    
    @objc private func creditCard(_ value: UITextField) {
        
        if !CreditCardValidator(value.text!).isValid || value.text!.count != 16{
            customerCreditCardErrorLabel.text = "Tarjeta Invalida"
            customerCreditCardErrorLabel.isHidden = false
        }
        else {
            customerCreditCardErrorLabel.text = ""
            customerCreditCardErrorLabel.isHidden = true
        }
    }
    
    @objc private func name(_ value: UITextField) {
        
        if   value.text!.isEmpty{
            customerNameErrorLabel.text = "Digitar Nombre"
            customerNameErrorLabel.isHidden = false
        }
        else {
            customerNameErrorLabel.text = ""
            customerNameErrorLabel.isHidden = true
        }
    }
    
    @objc private func creditLimit(_ value: UITextField) {
        
        if   value.text!.isEmpty{
            customerCreditLimitErrorLabel.text = "Digitar Limite de Credito"
            customerCreditLimitErrorLabel.isHidden = false
        }
        else {
            customerCreditLimitErrorLabel.text = ""
            customerCreditLimitErrorLabel.isHidden = true
        }
    }
    
    @objc private func iD(_ value: UITextField) {
        
        if   value.text!.isEmpty{
            customerIDErrorLabel.text = "Digitar Cedula"
            customerIDErrorLabel.isHidden = false
        }
        else if (!UserDocumentId().verify(value.text!)) {
            customerIDErrorLabel.text = "Cedula Invalida"
            customerIDErrorLabel.isHidden = false
        }
        else {
            customerIDErrorLabel.text = ""
            customerIDErrorLabel.isHidden = true
        }
    }
    
    func initTextFieldValidation() {
        
        customerCreditLimitTextField.addTarget(self, action: #selector(creditLimit), for: .editingChanged)
        customerIDTextField.addTarget(self, action: #selector(iD), for: .editingChanged)
        customerCreditCardTextField.addTarget(self, action: #selector(creditCard), for: .editingChanged)
        customerNameTextField
            .addTarget(self, action: #selector(name), for: .editingChanged)
    }
    
    func isInputValidationComplete(completion: (Bool) -> ()) {
        if let id = customerIDErrorLabel.text, let name = customerNameErrorLabel.text,let creditLimit = customerCreditLimitErrorLabel.text, let creditCard = customerCreditCardErrorLabel.text {
            completion( id.isEmpty && name.isEmpty && creditLimit.isEmpty && creditCard.isEmpty && !customerIDTextField.text!.isEmpty && !customerNameTextField.text!.isEmpty && !customerCreditCardTextField.text!.isEmpty && !customerCreditLimitTextField.text!.isEmpty)
       }
   }
    

}
