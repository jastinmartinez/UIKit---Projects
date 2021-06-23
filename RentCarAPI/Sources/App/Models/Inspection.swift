//
//  File.swift
//  
//
//  Created by Jastin on 15/6/21.
//

import Foundation
import Vapor
import Fluent

final class Inspection: ContenModel {
static var schema: String = "inspection"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "vehicle_id")
    var vehicle: Vehicle
    
    @Parent(key: "customer_id")
    var customer: Customer
    
    @Field(key: "inspection_scratch")
    var scratch: Bool
    
    @Field(key: "inspection_combustible_amount")
    var combustibleAmount: String
    
    @Field(key: "inpection_rubber_back")
    var rubberBack: Bool
    
    @Field(key: "inspection_hydraulic_jack")
    var hydraulicJack: Bool
    
    @Field(key: "inspection_glass_breakage")
    var glassBreakage: Bool
    
    @Field(key: "inspection_rubber_state_1")
    var rubberState1: Bool
    
    @Field(key: "inspection_rubber_state_2")
    var rubberState2: Bool
    
    @Field(key: "inspection_rubber_state_3")
    var rubberState3: Bool
    
    @Field(key: "inspection_rubber_state_4")
    var rubberState4: Bool
    
    @Field(key: "inspection_date")
    var date: String
    
    @Parent(key: "employee_id")
    var employee: Employee
    
    @Field(key: "inspection_state")
    var state: Bool
    
    init() {}
    
    init(id: UUID?, vehicle: UUID,customer: UUID,scratch: Bool,combustibleAmount: String,rubberBack: Bool,hydraulicJack: Bool,glassBreakage: Bool,rubberState1: Bool, rubberState2: Bool,rubberState3: Bool, rubberState4: Bool,date: String,employee: UUID,state: Bool) {
        
        self.id = id
        self.$vehicle.id = vehicle
        self.$customer.id = customer
        self.scratch = scratch
        self.combustibleAmount = combustibleAmount
        self.rubberBack = rubberBack
        self.hydraulicJack = hydraulicJack
        self.glassBreakage = glassBreakage
        self.rubberState1 = rubberState1
        self.rubberState2 = rubberState2
        self.rubberState3 = rubberState3
        self.rubberState4 = rubberState4
        self.date = date
        self.$employee.id = employee
        self.state = state
    }
}
