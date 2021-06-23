//
//  File.swift
//  
//
//  Created by Jastin on 20/6/21.
//

import Foundation

import Fluent
import Vapor

struct VehicleController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let vehicle = routes.grouped("vehicle")
        vehicle.post( use: add)
        vehicle.delete( use: delete)
        vehicle.put( use: update)
        vehicle.get( use: getAll)
        vehicle.post("validation", use: vehicleMultipleValidations)
    }
    
    func add(req: Request) throws -> EventLoopFuture<Vehicle> {
        let vehicle = try req.content.decode(Vehicle.self)
        return vehicle.save(on: req.db).map {vehicle}
    }
    
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let vehicle = try req.content.decode(Vehicle.self)
       
        return Vehicle.find(vehicle.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap({
              
                $0.description = vehicle.description
                $0.chasisNumber = vehicle.chasisNumber
                $0.engineNumber = vehicle.chasisNumber
                $0.plate = vehicle.plate
                $0.$vehicleType.id = vehicle.$vehicleType.id
                $0.$vehicleMark.id = vehicle.$vehicleMark.id
                $0.$vehicleModel.id = vehicle.$vehicleModel.id
                $0.$combustibleType.id = vehicle.$combustibleType.id
                $0.state = vehicle.state
                
                return $0.update(on: req.db)
                    .transform(to: .ok)
            })
    }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let vehicle = try req.content.decode(Vehicle.self)
        return Vehicle.find(vehicle.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap({ $0.delete(on: req.db)
                .transform(to: .ok)
        })
    }
    
    func getAll(req: Request) throws -> EventLoopFuture<[Vehicle]> {
        return Vehicle.query(on: req.db).all()
    }
    
    
    
    func vehicleMultipleValidations(_ req: Request) throws -> EventLoopFuture<[Vehicle]> {
        let vehicle = try req.content.decode(Vehicle.self)
        return Vehicle.query(on: req.db)
            .group(.or) {
                
            group in group
            .filter(\.$chasisNumber == vehicle.chasisNumber)
            .filter(\.$plate == vehicle.plate)
                
            }
            .all()
    }
}
