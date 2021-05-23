//
//  File.swift
//  
//
//  Created by Jastin on 16/5/21.
//

import Fluent
import Vapor

final class User: ContenModel {
    
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "user_name")
    var name: String
    
    @Field(key: "user_email")
    var email: String
    
    @Field(key: "user_password_hash")
    var passwordHash: String
    
    init() {
    }
    init(id: UUID? = nil, name: String, email: String,passwordHash: String)
    {
        self.id = id
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
    }
}

extension User {
    struct SignUp: Content {
        var name: String
        var email: String
        var password: String
        var confirmPassword: String
    }
}

extension User {
    struct SignIn: Content {
        var email: String
        var password: String
    }
}

extension User: ModelAuthenticatable {
    static let usernameKey = \User.$email
    static let passwordHashKey = \User.$passwordHash

    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.passwordHash)
    }
}

extension User {
    func generateToken() throws -> UserToken {
        try .init(
            value: [UInt8].random(count: 16).base64,
            userID: self.requireID()
        )
    }
}

extension User {
    struct  UserReponse : Content {
        var id: UUID
        var name: String
        var email: String
        var token: String
    }
}
