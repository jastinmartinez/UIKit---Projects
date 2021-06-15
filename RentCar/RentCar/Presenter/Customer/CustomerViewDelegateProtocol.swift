//
//  CustomerViewDelegate.swift
//  RentCar
//
//  Created by Jastin on 8/6/21.
//

import Foundation

protocol CustomerViewDelegateProtocol {
    func didCustomersChange()
    func didErrorOcurred(title:String, message:String)
}
