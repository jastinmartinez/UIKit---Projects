//
//  VehicleType.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation

struct VehicleType: Codable {
    var id: UUID?
    var description: String
    var state: Bool
}
