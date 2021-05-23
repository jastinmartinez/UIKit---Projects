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
    
    func signUp(req: Request) throws -> User.UserReponse  {
        
        try User.SignUp.validate(content: req)
        
        let create = try req.content.decode(User.SignUp.self)
        
        let user = try User (
            name: create.name,
            email: create.email,
            passwordHash: Bcrypt.hash(create.password)
        )

        let _ = user.save(on: req.db).map {  user }
        let token = try user.generateToken()
        let _ = token.save(on: req.db).map { token }
        let userResponse =  User.UserReponse(id: user.id!, name: user.name, email: user.email, token: token.value)
        return userResponse
    }
    
    func signIn(req: Request) throws -> User.UserReponse  {
        
        let user = try req.auth.require(User.self)
        
        let token = try user.generateToken()
        
        getUserToken(req: req, user: user) { value in
            if value.count > 0 {
                
                token.id = value[0].id
                
                let _ = token.update(on: req.db).map { token }
            }
            else {
                
                let _ = token.save(on: req.db).map { token }
            }
        }
       
        let userResponse =  User.UserReponse(id: user.id!, name: user.name, email: user.email, token: token.value)
        return userResponse
    }
    func getUserToken(req: Request,user: User,completion: @escaping ([UserToken])-> ()) {
        
       let _ = UserToken.query(on: req.db)
            .join(User.self, on: \User.$id == \UserToken.$user.$id)
            .all().map {
                completion($0)
            }
    }
    
    func me(req: Request) throws -> User  {
        
        try req.auth.require(User.self)
    }
}
