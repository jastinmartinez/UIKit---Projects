//
//  Date+ToString.swift
//  RentCar
//
//  Created by Jastin on 19/6/21.
//

import Foundation
extension Date {
   
    func ToFormatedDate() -> String {
        let dateFomart = DateFormatter()
        dateFomart.dateFormat = "yyyy-MM-dd"
        return dateFomart.string(from: self)
    }
}
