//
//  File.swift
//  
//
//  Created by Jastin on 6/6/21.
//

import Foundation

import Vapor
import Fluent

struct CustomerController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let customerRoute = routes.grouped("customer")
        customerRoute.post(use: create)
    }
    
    func create(_ req: Request) throws -> EventLoopFuture<Customer> {
        let customer = try req.content.decode(Customer.self)
        return customer.save(on: req.db).map { customer }
    }
}
