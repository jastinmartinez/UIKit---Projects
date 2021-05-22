//
//  AuthenticationViewModel.swift
//  RentCar
//
//  Created by Jastin on 17/5/21.
//

import Foundation

class AuthenticationViewModel {
    var userRepository: AuthenticationRepository
    
    init() {
        userRepository = AuthenticationRepository()
    }

    func signUp(user: SignUp) {
        
        var userDic: Dictionary<String,Any> = ["email": user.email,"name":user.name]
            
        userRepository.signUp(user: user){ userResponse in
            
            if let tryUserResponse = userResponse {
                userDic["id"] =  tryUserResponse.id
                userDic["token"] = tryUserResponse.value
                DbHelper().saveUser(for: userDic)
            }
        }
    }
}
