//
//  File.swift
//  
//
//  Created by Jastin on 5/6/21.
//

import Foundation
import Vapor
import Fluent

final class Customer: ContenModel {
    
    static var schema: String = "customer"

    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "customer_name")
    var name: String
    
    @Field(key: "customer_id")
    var customerID: String
    
    @Field(key: "customer_credit_card")
    var creditCard: String
    
    @Field(key: "customer_credit_limit")
    var creditLimit: Double
    
    @Field(key: "customer_person_type")
    var personType: String
    
    @Field(key: "customer_state")
    var state: Bool
    
    init () {}
    
    init (id: UUID?, name: String, customerID: String, creditCard: String, creditLimit: Double, personType: String, state: Bool) {
        self.id = id
        self.name = name
        self.customerID = customerID
        self.creditCard = creditCard
        self.creditLimit = creditLimit
        self.personType = personType
        self.state = state
    }
}
