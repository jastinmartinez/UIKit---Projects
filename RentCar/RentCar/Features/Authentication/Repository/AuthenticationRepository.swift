//
//  AuthenticationRepository.swift
//  RentCar
//
//  Created by Jastin on 18/5/21.
//

import Foundation

final class AuthenticationRepository  {
    
    func signUp(user: SignUp,  completion: @escaping (UserToken) -> ())  {
        IWebService().postRequest(resource: IPostResource<SignUp>(urlRequest: IURLRequest().prepare(method: .POST, url: RouteName.signUpUrl), model: user)){ data,_,error in
            if let tryData = data {
                let tryUserToken = try? JSONDecoder().decode(UserToken.self, from: tryData)
                if let tryUserResponse = tryUserToken {
                    completion(tryUserResponse)
                }
            }
        }
    }
    
    func signIn(user: SignIn,  completion: @escaping (UserToken) -> ())  {
        IWebService().postRequest(resource: IPostResource<SignIn>(urlRequest: IURLRequest().prepare(method: .POST, url: RouteName.signInUrl), model: user)){ data,_,error in
            if let tryData = data {
                let tryUserToken = try? JSONDecoder().decode(UserToken.self, from: tryData)
                if let tryUserResponse = tryUserToken {
                    completion(tryUserResponse)
                }
            }
        }
    }
}


