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
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var userErrorLabel: UILabel!
    @IBOutlet weak var confirmPasswordErrorLabel: UILabel!
    
    var authSwithValue: Bool = false
    let authenticationPresenter = AuthenticationPresenter(authenticationService: AuthenticationService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationPresenter.delegate = self
        validationEvents()
    }
    
    @IBAction func authPressed(_ sender: Any) {
        
        if (authSwithValue) {
            
            guard let email = emailTextField.text, let name = userNameTextField.text,let password = passwordTextField.text,let confirmpassword = confirmPasswordTextField.text else { return }
            
             authenticationPresenter.signUp(user: SignUp(name: name, email: email.lowercased(), password: password, confirmPassword: confirmpassword))
        }
        else {
            
            guard let email = emailTextField.text,let password = passwordTextField.text else { return }
            authenticationPresenter.signIn(user: SignIn(email: email.lowercased(), password: password))
        }
    }
    
    @IBAction func authSwithPressed(_ sender: UISwitch) {
        if (sender.isOn) {
            authSwithValue = true
            userNameTextField.isHidden = false
            confirmPasswordTextField.isHidden = false
            authButton.setTitle("Registrarme", for: .normal)
            
        }
        else {
            authSwithValue = false
            userNameTextField.isHidden = true
            confirmPasswordTextField.isHidden = true
            authButton.setTitle("Iniciar Sesion", for: .normal)
        }
    }
    
}




