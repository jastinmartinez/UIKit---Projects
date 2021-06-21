//
//  Date+ToString.swift
//  RentCar
//
//  Created by Jastin on 19/6/21.
//

import Foundation
extension Date {
    
    func toString() -> String {
        return  SetDateFormat().to.string(from: self)
    }
}
