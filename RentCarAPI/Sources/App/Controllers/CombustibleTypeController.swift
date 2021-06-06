//
//  File.swift
//  
//
//  Created by Jastin on 20/5/21.
//

import Foundation
import Vapor



struct CombustibleTypeController: RouteCollection,IController {
    
    typealias aType = CombustibleType
    
    func boot(routes: RoutesBuilder) throws {
        let combustibleTypeRoute = routes.grouped("combustibletype")
        combustibleTypeRoute.post(use:create)
        combustibleTypeRoute.put(use:update)
        combustibleTypeRoute.delete(use: remove)
        combustibleTypeRoute.get(use:getModelsOfMark)
    }
    
    func create(req: Request) throws -> EventLoopFuture<CombustibleType> {
        let combustibleContent = try req.content.decode(CombustibleType.self)
        let combustibleType = CombustibleType(description: combustibleContent.description, state: combustibleContent.state)
        return combustibleType.save(on: req.db).map { combustibleType }
    }
    
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        
        let combustibleType = try req.content.decode(CombustibleType.self)
        return CombustibleType.find(combustibleType.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.description = combustibleType.description
                $0.state = combustibleType.state
                return $0.update(on: req.db)
                    .transform(to: .ok)
            }
    }
    
    func remove(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let combustibleType = try req.content.decode(CombustibleType.self)
        
        return CombustibleType.find(combustibleType.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{$0.delete(on: req.db)
                .transform(to: .ok)}
        
    }
    
    func getModelsOfMark(req: Request) throws -> EventLoopFuture<[CombustibleType]> {
        
        return CombustibleType.query(on: req.db).all()
    }
}
