//
//  String+ToDate.swift
//  RentCar
//
//  Created by Jastin on 20/6/21.
//

import Foundation
extension  String {
    
    func toDate() -> Date {
        return SetDateFormat().to.date(from: self)!
    }
}
