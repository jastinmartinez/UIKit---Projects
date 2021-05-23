//
//  User.swift
//  RentCar
//
//  Created by Jastin on 17/5/21.
//

import Foundation

class User: Codable {
    var id: UUID
    var name: String
    var email: String
    var token: String
    
 
    init(id: UUID, name: String, email: String,token: String) {
        self.id = id
        self.name = name
        self.email = email
        self.token = token
    }
}

