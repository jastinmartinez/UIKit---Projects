//
//  File.swift
//  
//
//  Created by Jastin on 16/5/21.
//

import Foundation
import Vapor

struct UserController: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        
        let userRoute = routes.grouped("users")
        userRoute.post("signup", use: signUp)
        userRoute.post("signin", use: signIn)
    }
    
    func signUp(req: Request) throws -> EventLoopFuture<User>  {
        
        try User.Create.validate(content: req)
        
        let create = try req.content.decode(User.Create.self)
        
        guard create.password == create.confirmPassword else {
            throw Abort(.badRequest, reason: "Contraseñas no coinciden")
        }
        
        let user = try User (
            name: create.name,
            email: create.email,
            passwordHash: Bcrypt.hash(create.password)
        )
        return user.save(on: req.db).map{ user }
    }
    
    func signIn(req: Request) throws -> User {
        try req.auth.require(User.self)
    }
}
