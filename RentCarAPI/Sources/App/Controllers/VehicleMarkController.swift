////
////  File.swift
////
////
////  Created by Jastin on 5/6/21.
////
//
//import Foundation
//import Vapor
//
//struct VehicleMarkController: RouteCollection,IController {
//
//    typealias aType = VehicleMark
//
//    func boot(routes: RoutesBuilder) throws {
//        let vehicleMark = routes.grouped("VehicleMark")
//        vehicleMark.post(use: create)
//        vehicleMark.put(use: update)
//        vehicleMark.delete(use: remove)
//        vehicleMark.get(use: getAll)
//    }
//
//    func create(req: Request) throws -> EventLoopFuture<VehicleMark> {
//        let combustibleContent = try req.content.decode(VehicleMark.self)
//        let combustibleType = VehicleMark(description: combustibleContent.description, state: combustibleContent.state)
//        return combustibleType.save(on: req.db).map { combustibleType }
//
//    }
//
//    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
//        <#code#>
//    }
//
//    func remove(req: Request) throws -> EventLoopFuture<HTTPStatus> {
//        <#code#>
//    }
//
//    func getAll(req: Request) throws -> EventLoopFuture<[VehicleMark]> {
//        <#code#>
//    }
//}
