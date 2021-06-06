//
//  VehicleMark.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation
struct VehicleMark: Codable,ModelType {
    var id: UUID?
    var description: String
    var state: Bool
}
