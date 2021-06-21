//
//  Vehicle.swift
//  RentCar
//
//  Created by Jastin on 20/6/21.
//

import Foundation

struct Vehicle: Codable {

    var id: UUID? = nil
    var description: String
    var chasisNumber: String
    var engineNumber: String
    var plate: String
    var vehicleType: ParentModel
    var vehicleMark: ParentModel
    var vehicleModel: ParentModel
    var combustibleType: ParentModel
    var state: Bool
}

