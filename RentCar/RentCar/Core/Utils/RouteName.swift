//
//  Constant.swift
//  RentCar
//
//  Created by Jastin on 17/5/21.
//

import Foundation

struct RouteName {
    static let baseUrl =  "http://127.0.0.1:8080"
    
    static let signInUrl = URL(string: "\(baseUrl)/signin")!
    
    static let signUpUrl = URL(string: "\(baseUrl)/signup")!
}
