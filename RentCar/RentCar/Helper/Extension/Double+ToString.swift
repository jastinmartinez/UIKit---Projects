//
//  Double+ToString.swift
//  RentCar
//
//  Created by Jastin on 8/6/21.
//

import Foundation

extension Double {
    
    func ToString() -> String {
        
        return String(format: "%.2f", self)
    }
}
