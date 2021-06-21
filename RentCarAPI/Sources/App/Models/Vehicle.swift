//
//  File.swift
//  
//
//  Created by Jastin on 20/6/21.
//

import Foundation

final class Vehicle: ContenModel {
    
    static var schema: String = "vehicle"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "vehicle_description")
    var description: String
    
    @Field(key: "vehicle_chasis_number")
    var chasisNumber: String
    
    @Field(key: "vehicle_plate")
    var plate: String
    
    @Field(key: "vehicle_engine_number")
    var engineNumber: String
    
    
    @Parent(key: "vehicle_vehicle_type")
    var vehicleType: VehicleType
    
    @Parent(key: "vehicle_vehicle_mark")
    var vehicleMark: VehicleMark
    
    @Parent(key: "vehicle_vehicle_model")
    var vehicleModel: VehicleModel
    
    @Parent(key: "vehicle_combustible_type")
    var combustibleType: CombustibleType
    
    @Field(key: "vehicle_state")
    var state: Bool
    
    init() {}
    
    init(id: UUID?,description: String,chasisNumber: String, engineNumber: String,plate: String,vehicleType: UUID,vehicleMark: UUID,vehicleModel: UUID,combustibleType:UUID,state: Bool) {
        self.id = id
        self.description = description
        self.chasisNumber = chasisNumber
        self.engineNumber = engineNumber
        self.plate = plate
        self.$vehicleType.id = vehicleType
        self.$vehicleMark.id = vehicleMark
        self.$vehicleModel.id = vehicleModel
        self.$combustibleType.id = combustibleType
        self.state = state
    }
    
}
