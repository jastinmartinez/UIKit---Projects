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
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.signUp,model: user, method: .post)) { data, response, _  in
            if let data = data {
                if let user = DataToObject<User>.decode(single: data) {
                    UserDefaultsDbHelper().saveUser(user)
                }
            }
            if let statusCode = response?.statusCode {
                completion(GetErrorResponseStatusCode.StatusCode(statusCode).status)
            }
        }
    }
    
    func signIn(user: SignIn,completion: @escaping (Error?) -> ()) {
        
        let addtionalHeader =  HTTPHeader(name: "Authorization", value: "Basic \(Data("\(user.email):\(user.password)".utf8).base64EncodedString())")
        
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.signIn, addtionalHeaders: addtionalHeader ,model: user, method: .post)) { data, response, _  in
            if let data = data {
                if let user = DataToObject<User>.decode(single: data) {
                    UserDefaultsDbHelper().saveUser(user)
                }
            }
            if let statusCode = response?.statusCode {
                completion(GetErrorResponseStatusCode.StatusCode(statusCode).status)
            }
        }
    }
}

