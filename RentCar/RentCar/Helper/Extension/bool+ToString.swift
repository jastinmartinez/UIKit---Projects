//
//  bool+ToString.swift
//  RentCar
//
//  Created by Jastin on 31/5/21.
//

import Foundation

extension Bool {
    
    func ToStringState() -> String {
       if self {
            return "Activo"
        }
        else {
            return "Inactivo"
        }
    }
    func ToStringStatus() -> String {
       if self {
            return "Abierto"
        }
        else {
            return "Cerrado"
        }
    }
}
