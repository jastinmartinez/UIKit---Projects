//
//  AuthenticationViewController+.swift
//  RentCar
//
//  Created by Jastin on 30/5/21.
//

import Foundation

extension AuthenticationViewController: AuthenticationViewDelegate {
   
    func didErrorOcurred(error: Error) {
        
        self.present(AlertView().show(title: "Autenticacion", message: error.localizedDescription), animated: true, completion: nil)
    }
    
    func didUserAuthenticated(isUserAuthenticated: Bool) {
        
        if (isUserAuthenticated) {
            performSegue(withIdentifier: Constant.segue.managementSegue, sender: nil)
        }
    }
}
