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
    
    let authenticationViewModel = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validationEvents()
    }
    
    @IBAction func authPressed(_ sender: Any) {
        
        if (authSwithValue) {
            
            guard let email = emailTextField.text, let name = userNameTextField.text,let password = passwordTextField.text,let confirmpassword = confirmPasswordTextField.text else { return }
            
            authenticationViewModel.signUp(user: SignUp(name: name, email: email.lowercased(), password: password, confirmPassword: confirmpassword)) {
                isLoggedIn in
                if ( isLoggedIn){
                    let newViewController = Routes().name(routeName: .HomeViewController)!
                    self.present(newViewController, animated: true, completion: nil)
                }
            }
        }
        else {
            
            guard let email = emailTextField.text,let password = passwordTextField.text else { return }
            
            authenticationViewModel.signIn(user: SignIn(email: email.lowercased(), password: password)) {
                isLoggedIn in
                if let  error = isLoggedIn.error {
                    
                    self.present(AlertView().show(title: "Autenticacion", message: error.localizedDescription), animated: true, completion: nil)
                }
                else {
                    let newViewController = Routes().name(routeName: .HomeViewController)!
                    return self.present(newViewController, animated: true, completion: nil)
                }
            }
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




