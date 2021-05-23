//
//  SingUp.swift
//  RentCar
//
//  Created by Jastin on 21/5/21.
//

import Foundation

struct SignUp: Encodable {
    let name: String
    let email: String
    let password: String
    let confirmPassword: String
}
