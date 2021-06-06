//
//  File.swift
//
//
//  Created by Jastin on 5/6/21.
//

import Foundation
import Vapor

struct VehicleMarkController: RouteCollection,IController {
    
    typealias aType = VehicleMark
    
    func boot(routes: RoutesBuilder) throws {
        let vehicleMark = routes.grouped("vehiclemark")
        vehicleMark.post(use: create)
        vehicleMark.put(use: update)
        vehicleMark.delete(use: remove)
        vehicleMark.get(use: getModelsOfMark)
    }
    
    func create(req: Request) throws -> EventLoopFuture<VehicleMark> {
        let vehicleMark  = try req.content.decode(VehicleMark.self)
        return vehicleMark.save(on: req.db).map { vehicleMark }
        
    }
    
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let vehicleMark = try req.content.decode(VehicleMark.self)
        return
            VehicleMark
            .find(vehicleMark.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap({
                $0.description = vehicleMark.description
                $0.state = vehicleMark.state
                return $0
                    .update(on: req.db)
                    .transform(to: .ok)
            })
    }
    
    func remove(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let vehicleMark = try req.content.decode(VehicleMark.self)
        return VehicleMark
            .find(vehicleMark.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap({$0.delete(on: req.db)
                        .transform(to: .ok)})
    }
    
    func getModelsOfMark(req: Request) throws -> EventLoopFuture<[VehicleMark]> {
        return VehicleMark.query(on: req.db).all()
    }
}
