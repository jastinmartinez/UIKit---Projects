//
//  IService.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation

protocol IService: AnyObject {
    
    associatedtype aType
    
    func create(_ vm: aType, completion: @escaping (aType) -> ())
    
    func update(_ vm: aType)
    
    func getAll(completion: @escaping ([aType]) -> ())
    
    func Delete(vm: aType)
}
