//
//  User.swift
//  RentCar
//
//  Created by Jastin on 17/5/21.
//

import Foundation

struct User {
    
    struct UserSignUp: Codable {
        var name: String
        var email: String
        var password: String
        var confirmPassword: String
    }
    
    struct UserSignIn: Encodable {
        var name: String
        var password: String
    }
    
    struct UserResponse : Decodable {
        var id: UUID
        var value: String
        var user: UserResponseID
    }
    
     struct UserResponseID : Decodable {
        var id: UUID
    }
}

