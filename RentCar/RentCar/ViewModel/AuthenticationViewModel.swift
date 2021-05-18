//
//  AuthenticationViewModel.swift
//  RentCar
//
//  Created by Jastin on 17/5/21.
//

import Foundation

class AuthenticationViewModel {
    
    func signIn(user: User.UserSignIn) {
        
        let userResource = IGetResource<User.UserResponse>(url: Constant.SignInUrl) { data in
            let userResponse = try? JSONDecoder().decode(User.UserResponse.self, from: data)
            return userResponse
        } 

        IWebService().getRequest(resource: userResource){ result in
            print(1)
        }
    }
    
    func signUp(user: User.UserSignUp) {
        
        let  userResource = IPostResource<User.UserSignUp>(url: Constant.SignInUrl, model: user){ data in
            let userResponse = try? JSONDecoder().decode(User.UserSignUp.self, from: data)
            return userResponse
        }
        
        IWebService().postRequest(resource: userResource) { data in
            print(1)
        }
    }
}
