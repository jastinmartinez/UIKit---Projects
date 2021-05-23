//
//  AuthenticationViewModel.swift
//  RentCar
//
//  Created by Jastin on 17/5/21.
//

import Foundation

class AuthenticationViewModel {
    
    let userRepository: AuthenticationRepository
    
    init() {
        
        userRepository = AuthenticationRepository()
    }
    
    func signUp(user: SignUp,completion: @escaping (Bool)->())  {
        
        userRepository.signUp(user: user){ userToken in
            let userModel = User(id: userToken.id,name: user.name, email: user.email,token: userToken.value)
            DbHelper().saveUser(userModel)
            completion(DbHelper().isUserLoggedIn())
        }
    }
    func signIn(user: SignIn,completion: @escaping (Bool)->())  {
        
        userRepository.signIn(user: user){ userToken in
            let userModel = User(id: userToken.id,name: user.name, email: user.email,token: userToken.value)
            DbHelper().saveUser(userModel)
            completion(DbHelper().isUserLoggedIn())
        }
    }
}
