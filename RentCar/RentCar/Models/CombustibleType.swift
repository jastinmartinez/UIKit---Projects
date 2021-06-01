//
//  CombustibleType.swift
//  RentCar
//
//  Created by Jastin on 25/5/21.
//

import Foundation

struct CombustibleType: Codable {
    var id: UUID? = nil
    let description: String
    let state: Bool
}
