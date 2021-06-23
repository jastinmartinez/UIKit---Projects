//
//  Rent.swift
//  RentCar
//
//  Created by Jastin on 22/6/21.
//

import Foundation

struct Rent: Codable {
    var id: UUID? = nil
    var employee: ParentModel
    var customer: ParentModel
    var vehicle: ParentModel
    var date: String
    var amountPerDay: Double
    var amountOfDay: Int
    var comment: String
    var state: Bool
}
