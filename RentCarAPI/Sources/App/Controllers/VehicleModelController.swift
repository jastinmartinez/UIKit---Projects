//
//  File.swift
//  
//
//  Created by Jastin on 5/6/21.
//

import Foundation
import Vapor
import Fluent

final class VehicleModelController: RouteCollection,IController {
    
    typealias aType = VehicleModel
    
    func boot(routes: RoutesBuilder) throws {
        let vehicleModel = routes.grouped("vehiclemodel")
        vehicleModel.post( use: create)
        vehicleModel.put( use: update)
        vehicleModel.get(":vehicle_mark_id",use: getModelsOfMarks)
        vehicleModel.get(use: getAll)
        vehicleModel.delete( use: remove)
    }
    
    func create(req: Request) throws -> EventLoopFuture<VehicleModel> {
        let vehicleModel = try req.content.decode(VehicleModel.self)
        return vehicleModel.save(on: req.db).map({vehicleModel})
    }
    
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let vehicleModel = try req.content.decode(VehicleModel.self)
        return VehicleModel
            .find(vehicleModel.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap({
                $0.description = vehicleModel.description
                $0.state = vehicleModel.state
                $0.$vehicleMark.id = vehicleModel.$vehicleMark.id
                return $0.update(on: req.db)
                    .transform(to: .ok)
            })
    }
    
    func remove(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let vehicleModel = try req.content.decode(VehicleModel.self)
        return VehicleModel
            .find(vehicleModel.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap(
                { $0.delete(on: req.db)
                    .transform(to: .ok)
            })
    }
    
    func getAll(req: Request) throws -> EventLoopFuture<[VehicleModel]> {
        
        return VehicleModel.query(on: req.db).all()
    }
    
    func getModelsOfMarks(req: Request) throws -> EventLoopFuture<[VehicleModel]> {
        
       return VehicleModel.query(on: req.db)
            .join(VehicleMark.self, on: \VehicleModel.$vehicleMark.$id == \VehicleMark.$id)
            .filter(VehicleMark.self, \.$id ==  UUID.init(uuidString: req.parameters.get("vehicle_mark_id")!)!)
            .all()
    }
}
