//
//  BindOutlets.swift
//  RentCar
//
//  Created by Jastin on 31/5/21.
//

import Foundation
protocol BindOutletsProtocol {
    associatedtype aType
    func bindDataToOulets(vm: aType)
}
