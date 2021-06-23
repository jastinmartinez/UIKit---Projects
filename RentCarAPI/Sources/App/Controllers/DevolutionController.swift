//
//  File.swift
//  
//
//  Created by Jastin on 22/6/21.
//

import Foundation

import Vapor

struct DevolutionController: RouteCollection,IController {
    
    func create(req: Request) throws -> EventLoopFuture<Devolution> {
        let devolution = try req.content.decode(Devolution.self)
        return devolution.save(on: req.db).map({devolution})
    }
    
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let devolution = try req.content.decode(Devolution.self)
        return Devolution.find(devolution.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap({
                $0.$vehicle.id = devolution.$vehicle.id
                $0.$employee.id = devolution.$employee.id
                $0.$customer.id = devolution.$customer.id
                $0.amountOfDay = devolution.amountOfDay
                $0.amountPerDay = devolution.amountPerDay
                $0.date = devolution.date
                $0.comment = devolution.comment
                $0.$rent.id = devolution.$rent.id
                
                return $0.update(on: req.db)
                    .transform(to: .ok)
            })
    }
    
    func remove(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let devolution = try req.content.decode(Devolution.self)
        return Devolution.find(devolution.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap({$0.delete(on: req.db).transform(to: .ok)})
    }
    
    func getAll(req: Request) throws -> EventLoopFuture<[Devolution]> {
        return Devolution.query(on: req.db).all()
    }
    
    func boot(routes: RoutesBuilder) throws {
        let devolutionRoute = routes.grouped("devolution")
        devolutionRoute.post( use: create)
        devolutionRoute.put( use: update)
        devolutionRoute.get( use: getAll)
        devolutionRoute.delete(use: remove)
    }
    
    typealias aType = Devolution
    
    
}
