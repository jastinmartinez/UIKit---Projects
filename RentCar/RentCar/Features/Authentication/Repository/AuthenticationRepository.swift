//
//  AuthenticationRepository.swift
//  RentCar
//
//  Created by Jastin on 18/5/21.
//

import Foundation

final class AuthenticationRepository {
    
    func signUp(user: SignUp,completion: @escaping (UserToken?) -> ())  {
        var urlRequest = URLRequest(url: URL(string: "\(RouteName.SignUpUrl)")!)
        urlRequest.httpMethod = HttpMethods.POST.rawValue
        let signUp = IPostResource<SignUp>(urlRequest: urlRequest, model: user)
        IWebService().postRequest(resource: signUp){ data,_,error in
            if let tryData = data {
                let tryUserToken = try? JSONDecoder().decode(UserToken.self, from: tryData)
                completion(tryUserToken)
            }
        }
    }
}


