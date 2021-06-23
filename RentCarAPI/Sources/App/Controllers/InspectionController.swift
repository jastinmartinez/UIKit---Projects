//
//  File.swift
//  
//
//  Created by Jastin on 22/6/21.
//

import Foundation
import Fluent
import Vapor

struct InspectionController: RouteCollection,IController {
    
    
    func create(req: Request) throws -> EventLoopFuture<Inspection> {
        let inspection = try req.content.decode(Inspection.self)
        
        return inspection.save(on: req.db).map({inspection})
    }
    
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let inspection = try  req.content.decode(Inspection.self)
        return Inspection.find(inspection.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            
            .flatMap({
                $0.$vehicle.id = inspection.$vehicle.id
                $0.$customer.id = inspection.$customer.id
                $0.$employee.id = inspection.$employee.id
                $0.combustibleAmount = inspection.combustibleAmount
                $0.date = inspection.date
                $0.glassBreakage = inspection.glassBreakage
                $0.rubberState1 = inspection.rubberState1
                $0.rubberState2 = inspection.rubberState2
                $0.rubberState3 = inspection.rubberState3
                $0.rubberState4 = inspection.rubberState4
                $0.rubberBack = inspection.rubberBack
                $0.scratch = $0.scratch
                $0.hydraulicJack = inspection.hydraulicJack
                $0.state = $0.state
                
                return $0.update(on: req.db)
                    .transform(to: .ok)
            })
    }
    
    func remove(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        
        let inspetion = try req.content.decode(Inspection.self)
        
        return Inspection.find(inspetion.id, on: req.db).unwrap(or: Abort(.notFound)).flatMap({$0.delete(on: req.db).transform(to: .ok)})
    }

    func inspectionJoinVehicle(req: Request) throws -> EventLoopFuture<[Inspection]> {
        
        return Inspection.query(on: req.db).all()
    }

    
    func getAll(req: Request) throws -> EventLoopFuture<[Inspection]> {
        
        return Inspection.query(on: req.db).all()
    }
    
    typealias aType = Inspection
    
    
    func boot(routes: RoutesBuilder) throws {
        
        let inspectionRoute  = routes.grouped("inspection")
        inspectionRoute.post( use: create)
        inspectionRoute.put( use: update)
        inspectionRoute.get( use: getAll)
        inspectionRoute.delete( use: remove)
    }
    
}
