//
//  File.swift
//  
//
//  Created by Jastin on 5/6/21.
//

import Foundation
import Vapor

struct VehicleTypeController: RouteCollection,IController {
    
    func boot(routes: RoutesBuilder) throws {
        let vehicleType = routes.grouped("vehicletype")
        vehicleType.post( use: create)
        vehicleType.put( use: update)
        vehicleType.delete( use: remove)
        vehicleType.get( use: getAll)
    }
    
    typealias aType = VehicleType
    
    func create(req: Request) throws -> EventLoopFuture<VehicleType> {
        let vehicleType = try req.content.decode(VehicleType.self)
        return vehicleType.save(on: req.db).map {vehicleType}
    }
    
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let vehicleType = try req.content.decode(VehicleType.self)
        return VehicleType
            .find(vehicleType.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap({
                $0.description = vehicleType.description
                $0.state = vehicleType.state
                return $0
                    .update(on: req.db)
                    .transform(to: .ok)
            })
    }
    
    func remove(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let vehicleType = try req.content.decode(VehicleType.self)
        return VehicleType
            .find(vehicleType.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap({$0.delete(on: req.db)
                            .transform(to: .ok)})
    }
    
    func getAll(req: Request) throws -> EventLoopFuture<[VehicleType]> {
        return VehicleType.query(on: req.db).all()
    }
    

    
    
}
