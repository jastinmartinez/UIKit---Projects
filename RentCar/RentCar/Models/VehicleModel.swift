//
//  VehicleModel.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation
struct VehicleModel: Codable,ModelType {
    var id: UUID?
    var description: String
    var vehicleMark: ParentModel
    var state: Bool
}


