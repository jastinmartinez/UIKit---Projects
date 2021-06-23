//
//  File.swift
//  
//
//  Created by Jastin on 22/6/21.
//

import Foundation

final class Rent: ContenModel {
    
    static var schema: String = "rent"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "employee_id")
    var employee: Employee
    
    @Parent(key: "customer_id")
    var customer: Customer
    
    @Field(key: "rent_date")
    var date: String
    
    @Field(key: "rent_amount_per_day")
    var amountPerDay: Double
    
    @Field(key: "rent_amount_of_day")
    var amountOfDay: Int
    
    @Field(key: "rent_comment")
    var comment: String
    
    @Field(key: "rent_state")
    var state: Bool
    
    init () {}
    
    init(id: UUID?, employee: UUID, customer: UUID, date: String, amountPerDay: Double, amountOfDay: Int,comment: String,state: Bool) {
        self.id = id
        self.$employee.id = employee
        self.$customer.id = customer
        self.date = date
        self.amountPerDay = amountPerDay
        self.amountOfDay = amountOfDay
        self.comment = comment
        self.state = state
    }
}
