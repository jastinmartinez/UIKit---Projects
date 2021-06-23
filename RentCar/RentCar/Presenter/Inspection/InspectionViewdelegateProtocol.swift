//
//  InspectionProtocol.swift
//  RentCar
//
//  Created by Jastin on 22/6/21.
//

import Foundation

protocol InspectionViewdelegateProtocol {
    func didInspectionsChange()
    func didErrorOcurred(title: String , message: String)
}
