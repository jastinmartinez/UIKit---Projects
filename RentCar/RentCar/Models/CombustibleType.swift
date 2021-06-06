//
//  CombustibleType.swift
//  RentCar
//
//  Created by Jastin on 25/5/21.
//

import Foundation

struct CombustibleType: Codable,ModelType {
    var id: UUID? = nil
    var description: String
    var state: Bool
}
