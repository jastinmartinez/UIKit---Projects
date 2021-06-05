//
//  AuthenticationService.swift
//  RentCar
//
//  Created by Jastin on 30/5/21.
//

import Foundation
import Alamofire

class AuthenticationService {
    
    func signUp(user: SignUp,completion:@escaping (Error?) -> ()) {
        APIService().request(url: RequestBuilder().prepare(url: Constant.uRL.signUp,model: user, method: .post)) { data, response, _  in
            if let data = data {
                let userDecoded = try? JSONDecoder().decode(User.self, from: data)
                if let user = userDecoded {
                    DbHelper().saveUser(user)
                }
            }
            completion(GetErrorResponseStatusCode.StatusCode(response!.statusCode).status)
        }
    }
    
    func signIn(user: SignIn,completion: @escaping (Error?) -> ()) {
        
        let addtionalHeader =  HTTPHeader(name: "Authorization", value: "Basic \(Data("\(user.email):\(user.password)".utf8).base64EncodedString())")
        
        APIService().request(url: RequestBuilder().prepare(url: Constant.uRL.signIn, header: addtionalHeader ,model: user, method: .post)) { data, response, _  in
            if let data = data {
                let userDecoded = try? JSONDecoder().decode(User.self, from: data)
                if let user = userDecoded {
                    DbHelper().saveUser(user)
                }
            }
            completion(GetErrorResponseStatusCode.StatusCode(response!.statusCode).status)
        }
    }
}

