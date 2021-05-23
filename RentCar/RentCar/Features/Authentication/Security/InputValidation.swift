//
//  InputValidation.swift
//  RentCar
//
//  Created by Jastin on 22/5/21.
//

import UIKit

extension AuthenticationViewController {
    
    @objc func validateEmail(textField: UITextField) {
        
        if (textField.text!.isEmpty)
        {
            emailErrorLabel.text = "Digitar Correo"
            emailErrorLabel.isHidden = false
        }
        else if (!isValidEmail(textField.text!)) {
            emailErrorLabel.text = "Direccion de Correo Invalida"
            emailErrorLabel.isHidden = false
        }
        else
        {
            emailErrorLabel.text = ""
            emailErrorLabel.isHidden = true
            enableButtonWhenValidationFinish()
        }
    }
    
    
    @objc func validateUser(textField: UITextField) {
        
        if (textField.text!.isEmpty)
        {
            userErrorLabel.text = "Digitar Usuario"
            userErrorLabel.isHidden = false
        }
        else if (textField.text!.count < 4) {
            userErrorLabel.text = "Usuario muy corto \(textField.text!.count) Minimo (4)"
            userErrorLabel.isHidden = false
        }
        else
        {
            userErrorLabel.text = ""
            userErrorLabel.isHidden = true
            enableButtonWhenValidationFinish()
        }
    }
    
    @objc func validatePassword(textField: UITextField) {
        
        if (textField.text!.isEmpty)
        {
            passwordErrorLabel.text = "Digitar Contraseña"
            passwordErrorLabel.isHidden = false
        }
        else if (textField.text!.count < 8 ) {
            passwordErrorLabel.text = "Contraseña muy corta \(textField.text!.count) Minimo (8)"
            passwordErrorLabel.isHidden = false
        }
        else
        {
            passwordErrorLabel.text = ""
            passwordErrorLabel.isHidden = true
            enableButtonWhenValidationFinish()
        }
    }
    
    @objc func validateConfirmPassword(textField: UITextField){
        if (textField.text!.isEmpty)
        {
            confirmPasswordErrorLabel.text = "Digitar Correo"
            confirmPasswordErrorLabel.isHidden = false
        }
        else if (textField.text!.count < 8 ) {
            confirmPasswordErrorLabel.text = "Contraseña muy corta \(textField.text!.count) Minimo (8)"
            confirmPasswordErrorLabel.isHidden = false
        }
        else if (textField.text! != passwordTextField.text ) {
            confirmPasswordErrorLabel.text = "Contraseña no coinciden"
            confirmPasswordErrorLabel.isHidden = false
        }
        else
        {
            confirmPasswordErrorLabel.text = ""
            confirmPasswordErrorLabel.isHidden = true
            enableButtonWhenValidationFinish()
        }
    }
    
    fileprivate func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    fileprivate func enableButtonWhenValidationFinish() {
        if let email = emailErrorLabel.text, let name = userErrorLabel.text,let password = passwordErrorLabel.text,let confirmpassword = confirmPasswordErrorLabel.text {
            if authSwithValue {
                if (email.isEmpty && name.isEmpty && password.isEmpty && confirmpassword.isEmpty) {
                    authButton.isEnabled = true
                }else {
                    authButton.isEnabled = false
                }
            }
            else {
                if (email.isEmpty && password.isEmpty ) {
                    authButton.isEnabled = true
                }else {
                    authButton.isEnabled = false
                }
            }
            
        }
    }
    
    func validationEvents(){
        emailTextField.addTarget(self, action: #selector(validateEmail), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(validateUser), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(validatePassword), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(validateConfirmPassword), for: .editingChanged)
    }
}
