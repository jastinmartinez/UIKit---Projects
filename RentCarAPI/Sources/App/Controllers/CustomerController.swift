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
        customerRoute.get(use: getAll)
        customerRoute.post("validation",use: customerIDAndCreditCardValidation)
        customerRoute.post(use: create)
        customerRoute.put(use: update)
        customerRoute.delete(use: remove)
    }
    
    func create(_ req: Request) throws -> EventLoopFuture<Customer> {
        let customer = try req.content.decode(Customer.self)
        return customer.save(on: req.db).map { customer }
    }
    
    func update(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let customer = try req.content.decode(Customer.self)
       
        return Customer.find(customer.id!, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap(
                {
                    $0.name = customer.name
                    $0.creditCard = customer.creditCard
                    $0.creditLimit = customer.creditLimit
                    $0.personType = customer.personType
                    $0.state = customer.state
                   
                    return $0.update(on: req.db)
                        .transform(to: .ok)
                }
            )
    }
    func getAll(_ req: Request) throws -> EventLoopFuture<[Customer]> {
        return Customer.query(on: req.db).all()
    }
    
    func remove(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let customer = try req.content.decode(Customer.self)
        return Customer.find(customer.id!, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap(
                {
                    $0.delete(on: req.db)
                        .transform(to: .ok)
                    
                }
            )
    }
    
    func customerIDAndCreditCardValidation(_ req: Request) throws -> EventLoopFuture<[Customer]> {
        let customer = try req.content.decode(Customer.self)
        return Customer.query(on: req.db)
            .group(.or) {
            group in group.filter(\.$creditCard == customer.creditCard)
            .filter(\.$customerID == customer.customerID) }
            .all()
    }
}
