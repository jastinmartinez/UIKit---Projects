//
//  Constant.swift
//  RentCar
//
//  Created by Jastin on 17/5/21.
//

import Foundation

struct RouteName {
    static let BaseUrl =  "http://127.0.0.1:8080"
    
    static let SignInUrl = URL(string: "\(BaseUrl)/signin")!
    
    static let SignUpUrl = URL(string: "\(BaseUrl)/signup")!
}
