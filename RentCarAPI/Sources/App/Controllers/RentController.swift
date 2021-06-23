//
//  File.swift
//  
//
//  Created by Jastin on 22/6/21.
//

import Foundation
import Vapor

struct RentController: RouteCollection,IController {
    
    
    func create(req: Request) throws -> EventLoopFuture<Rent> {
        let rent = try req.content.decode(Rent.self)
        return rent.save(on: req.db).map({rent})
    }
    
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let rent = try req.content.decode(Rent.self)
        return Rent.find(rent.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap({
                $0.amountPerDay = rent.amountPerDay
                $0.amountOfDay = rent.amountOfDay
                $0.$customer.id = rent.$customer.id
                $0.$employee.id = rent.$employee.id
                $0.comment = rent.comment
                $0.date = rent.date
                $0.state = rent.state
                
                return $0.update(on: req.db).transform(to: .ok)
            })
    }
    
    func remove(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let rent = try req.content.decode(Rent.self)
        return Rent.find(rent.id, on: req.db).unwrap(or: Abort(.notFound)).flatMap({$0.delete(on: req.db).transform(to: .ok)})
    }
    
    func getAll(req: Request) throws -> EventLoopFuture<[Rent]> {
        return Rent.query(on: req.db).all()
    }
    
    typealias aType = Rent
    
    func boot(routes: RoutesBuilder) throws {
        let rentRoute = routes.grouped("rent")
        rentRoute.post( use: create)
        rentRoute.put( use: update)
        rentRoute.get( use: getAll)
        rentRoute.delete( use: remove)
    }
}
