//
//  IPresenter.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation

protocol IPresenter: AnyObject {
    associatedtype aType
    
    func create(vm: aType)
    
    func getAll()
    
    func update(vm: aType)
    
    func remove(for index: Int)
    
}
