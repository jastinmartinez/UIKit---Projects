//
//  Customer.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation

struct Customer: Codable {
   
    var id: UUID?
    var name: String
    var customerID: String
    var creditCard: String
    var creditLimit: Double
    var personType: String
    var state: Bool
    
}
