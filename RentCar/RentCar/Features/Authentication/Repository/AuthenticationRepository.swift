//
//  AuthenticationRepository.swift
//  RentCar
//
//  Created by Jastin on 18/5/21.
//

import Foundation

final class AuthenticationRepository  {
    
    func signUp(user: SignUp,  completion: @escaping (User) -> ())  {
        IWebService().postRequest(resource: IPostResource<SignUp>(urlRequest: IURLRequest().prepare(method: .POST, url: RouteName.signUpUrl, parameters: nil), model: user)){ data,_,error in
            if let tryData = data {
                let tryUserToken = try? JSONDecoder().decode(User.self, from: tryData)
                if let tryUserResponse = tryUserToken {
                    completion(tryUserResponse)
                }
            }
        }
    }
    
    func signIn(user: SignIn,  completion: @escaping (IResult<User>) -> ())  {
        IWebService().postRequest(resource: IPostResource<SignIn>(urlRequest: IURLRequest().prepare(method: .POST, url: RouteName.signInUrl, parameters: ("Authorization","Basic \(Data("\(user.email):\(user.password)".utf8).base64EncodedString())")), model: user)){ data,response,error in
            if let tryData = data,let response = response as? HTTPURLResponse {
                let tryUser = try? JSONDecoder().decode(User.self, from: tryData)
                completion(IResult(result: tryUser, error: HttpGetStatusCode.StatusCode(response.statusCode).status))
            }
        }
    }
}


