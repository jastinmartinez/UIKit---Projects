//
//  File.swift
//  
//
//  Created by Jastin on 5/6/21.
//

import Foundation
import Vapor
import Fluent

final class VehicleModel: ContenModel {
    
    static var schema: String = "vehicle_model"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "vehicle_model_description")
    var description: String
    
    @Parent(key: "vehicle_mark_id")
    var vehicleMark: VehicleMark
    
    @Field(key: "vehicle_model_state")
    var state: Bool
    
    
    init() {}
    
    init(id: UUID?,description: String, state: Bool,vehicleMark: UUID) {
        self.id = id
        self.description = description
        self.state = state
        self.$vehicleMark.id = vehicleMark
    }
}
