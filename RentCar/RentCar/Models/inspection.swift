//
//  inspection.swift
//  RentCar
//
//  Created by Jastin on 22/6/21.
//

import Foundation

struct Inspection: Codable {
    
    var id: UUID? = nil
    var vehicle: ParentModel
    var customer: ParentModel
    var scratch: Bool
    var combustibleAmount: String
    var rubberBack: Bool
    var hydraulicJack: Bool
    var glassBreakage: Bool
    var rubberState1: Bool
    var rubberState2: Bool
    var rubberState3: Bool
    var rubberState4: Bool
    var date: String
    var employee: ParentModel
    var state: Bool
}
