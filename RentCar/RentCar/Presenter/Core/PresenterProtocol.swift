//
//  IPresenter.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation

protocol PresenterProtocol: AnyObject {
    associatedtype aType
    
    func create(_ vm: aType)
    
    func getAll()
    
    func update(_ vm: aType)
    
    func remove(for index: Int)
    
}

