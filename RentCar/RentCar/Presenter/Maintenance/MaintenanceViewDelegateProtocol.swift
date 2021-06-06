//
//  CombustibleTypeViewDelegate.swift
//  RentCar
//
//  Created by Jastin on 30/5/21.
//

import Foundation

protocol MaintenanceViewDelegateProtocol: AnyObject {
    func didArrayChange()
    func didErrorOcurred(title:String, message:String)
}

