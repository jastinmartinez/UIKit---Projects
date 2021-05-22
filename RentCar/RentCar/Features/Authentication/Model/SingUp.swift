//
//  SingUp.swift
//  RentCar
//
//  Created by Jastin on 21/5/21.
//

import Foundation

struct SignUp: Encodable {
    var name: String
    var email: String
    var password: String
    var confirmPassword: String
}
