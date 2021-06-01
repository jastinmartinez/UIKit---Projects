//
//  BindOutlets.swift
//  RentCar
//
//  Created by Jastin on 31/5/21.
//

import Foundation
protocol BindOutlets {
    associatedtype aType
    func bindDataToOulets(vm: aType)
}
