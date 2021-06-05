//
//  bool+ToString.swift
//  RentCar
//
//  Created by Jastin on 31/5/21.
//

import Foundation

extension Bool {
    
    func ToString() -> String {
       if self {
            return "Activo"
        }
        else {
            return "Inactivo"
        }
    }
}
