//
//  File.swift
//  
//
//  Created by Jastin on 16/5/21.
//

import Foundation
import Vapor
import Fluent


struct UserController: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        
        routes.post("signup", use: signUp)
        routes.grouped(User.authenticator()).post("sign", use: signIn)
        routes.grouped(UserToken.authenticator()).get("me", use: me)
        
    }
    
    func signUp(req: Request) throws -> EventLoopFuture<UserToken>  {
        
        try User.SignUp.validate(content: req)
        
        let create = try req.content.decode(User.SignUp.self)
        
        let user = try User (
            name: create.name,
            email: create.email,
            passwordHash: Bcrypt.hash(create.password)
        )

        let _ = user.save(on: req.db).map {  user }
        
        let token = try user.generateToken()
        
        return token.save(on: req.db).map { token }
    }
    
    func signIn(req: Request) throws -> EventLoopFuture<UserToken>  {
        
        let user = try req.auth.require(User.self)
        
        let token = try user.generateToken()
        
        return token.save(on: req.db).map { token }
    }
    
    func me(req: Request) throws -> User  {
        
        try req.auth.require(User.self)
    }
}
