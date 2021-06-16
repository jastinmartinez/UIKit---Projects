//
//  File.swift
//  
//
//  Created by Jastin on 6/6/21.
//

import Foundation
import Vapor
import Fluent

struct EmployeeController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let employeeRoute = routes.grouped("employee")
        employeeRoute.post(use: create)
        employeeRoute.put(use: update)
        employeeRoute.delete(use: remove)
        employeeRoute.get(use: getAll)
        employeeRoute.post(use: employeeIDValidation)
    }
    
    func create(_ req: Request) throws -> EventLoopFuture<Employee> {
        let employee = try req.content.decode(Employee.self)
        return employee.save(on: req.db).map {employee}
    }
    
    func update(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        
        let employee = try req.content.decode(Employee.self)
        
        return Employee.find(employee.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap({
                
                $0.name = employee.name
                $0.employeeID = employee.employeeID
                $0.jobShift = employee.jobShift
                $0.startedDate = employee.startedDate
                $0.state = employee.state
                
                return $0.update(on: req.db)
                    .transform(to: .ok)
            })
    }
    
    func remove (_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let employee = try req.content.decode(Employee.self)
        return Employee.find(employee.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap({
                        $0.delete(on: req.db)
                        .transform(to: .ok)
                
            })
    }
    
    func getAll(_ req: Request) throws -> EventLoopFuture<[Employee]> {
        
        return Employee.query(on: req.db).all()
    }
    
    func employeeIDValidation(_ req: Request) throws -> EventLoopFuture<[Employee]>
    {
        let employee = try req.content.decode(Employee.self)
        
        return Employee.query(on: req.db).filter(\.$employeeID == employee.employeeID).all()
    }
}
 
