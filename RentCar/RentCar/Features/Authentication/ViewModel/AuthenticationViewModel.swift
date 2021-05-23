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
            let userModel = User(id: userToken.id,name: userToken.name, email: userToken.email,token: userToken.token)
            DbHelper().saveUser(userModel)
            completion(DbHelper().isUserLoggedIn())
        }
    }
    
    func signIn(user: SignIn,completion: @escaping (IResult<Bool>)->())  {
        
        userRepository.signIn(user: user){ userResult in
            if let user = userResult.result {
                let userModel = User(id: user.id,name: user.name, email: user.email,token: user.token)
                DbHelper().saveUser(userModel)
            }
            completion(IResult(result: DbHelper().isUserLoggedIn(), error: userResult.error))
        }
    }
}
