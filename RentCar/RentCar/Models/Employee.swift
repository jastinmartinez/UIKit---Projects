//
//  Employee.swift
//  RentCar
//
//  Created by Jastin on 6/6/21.
//

import Foundation

struct Employee : Codable
{
    var id: UUID? = nil
    var name: String
    var employeeID: String
    var jobShift: String
    var commissionPercent: Int
    var startedDate: String
    var state: Bool
}
