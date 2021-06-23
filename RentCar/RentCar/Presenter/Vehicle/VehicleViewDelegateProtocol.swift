//
//  VehicleViewDelegate.swift
//  RentCar
//
//  Created by Jastin on 20/6/21.
//

import Foundation
protocol VehicleViewDelegateProtocol {
    func didVehicleArrayChange()
    func didErrorOcurred(title: String , message: String)
}

extension VehicleViewDelegateProtocol {
    func didErrorOcurred(title: String , message: String) {}
    
}
