//
//  Customer.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation

struct Customer: Codable,ModelType {
   
    var id: UUID? = nil
    var name: String
    var customerID: String
    var creditCard: String
    var creditLimit: Double
    var personType: String
    var state: Bool
    
}
