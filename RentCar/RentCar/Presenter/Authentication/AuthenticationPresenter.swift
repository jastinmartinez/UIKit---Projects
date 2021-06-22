//
//  AuthenticationViewModel.swift
//  RentCar
//
//  Created by Jastin on 17/5/21.
//

import Foundation

class AuthenticationPresenter {
    
    private var authenticationService: AuthenticationService
    
    var delegate: AuthenticationViewDelegate?
    
    init(authenticationService: AuthenticationService) {
        
        self.authenticationService = authenticationService
    }
    
    func signUp(user: SignUp) {
        
        self.authenticationService.signUp(user: user){ userError in
            if let error = userError {
                self.delegate?.didErrorOcurred(error: error)
            }
            else {
                self.delegate?.didUserAuthenticated(isUserAuthenticated: true)
            }
        }
    }
    
    
    func signIn(user: SignIn)   {
        authenticationService.signIn(user: user) { userError in
            if let error = userError {
                self.delegate?.didErrorOcurred(error: error)
            }
            else {
                self.delegate?.didUserAuthenticated(isUserAuthenticated: true)
            }
        }
    }
}

