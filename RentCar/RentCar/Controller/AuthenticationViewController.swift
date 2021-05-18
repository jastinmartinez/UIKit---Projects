//
//  AuthenticationViewController.swift
//  RentCar
//
//  Created by Jastin on 17/5/21.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var authButton: UIButton!
    
    
    let authenticationViewModel = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signPressed(_ sender: Any) {
        
        guard let email = emailTextField.text, let name = userNameTextField.text,let password = passwordTextField.text,let confirmpassword = confirmPasswordTextField.text else { return }
        
        authenticationViewModel.signUp(user: User.UserSignUp(name: name, email: email, password: password, confirmPassword: confirmpassword))
    }
    
    @IBAction func authSwithPressed(_ sender: UISwitch) {
        if (sender.isOn) {
            userNameTextField.isHidden = false
            confirmPasswordTextField.isHidden = false
            authButton.setTitle("Registrarme", for: .normal)
        }
        else {
            userNameTextField.isHidden = true
            confirmPasswordTextField.isHidden = true
            authButton.setTitle("Iniciar Sesion", for: .normal)
        }
    }
}




