//
//  File.swift
//  
//
//  Created by Jastin on 6/6/21.
//

import Foundation
import Fluent
import Vapor

final class Employee: ContenModel {
    
    static var schema: String = "employee"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "employee_id")
    var employeeID: String
    
    @Field(key: "employee_name")
    var name: String
    
    @Field(key: "employee_job_shift")
    var jobShift: String
    
    @Field(key: "employee_commission_percent")
    var commissionPercent: Double
    
    @Field(key: "employee_started_date")
    var startedDate: Date
    
    @Field(key: "employee_state")
    var state: Bool
    
    init() { }
    
    init(id: UUID?,employeeID: String,name: String, jobShift: String,commissionPercent: Double,startedDate: Date, state: Bool)
    {
        self.id = id
        self.employeeID = employeeID
        self.name = name
        self.jobShift = jobShift
        self.commissionPercent = commissionPercent
        self.startedDate = startedDate
        self.state = state
    }
}
