//
//  Devolution.swift
//  RentCar
//
//  Created by Jastin on 22/6/21.
//

import Foundation
struct Devolution: Codable {
    var id: UUID?
    var rent: ParentModel
    var employee: ParentModel
    var customer: ParentModel
    var vehicle: ParentModel
    var date: String
    var amountPerDay: Double
    var amountOfDay: Int
    var comment: String
    var state: Bool
}
