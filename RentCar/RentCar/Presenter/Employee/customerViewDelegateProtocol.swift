//
//  customerViewDelegateProtocol.swift
//  RentCar
//
//  Created by Jastin on 15/6/21.
//

import Foundation

protocol EmployeeViewDelegateProtocol {
    func didEmployeesChange()
    func didErrorOcurred(title: String , message: String)
}
