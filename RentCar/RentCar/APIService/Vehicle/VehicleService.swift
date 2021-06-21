//
//  VehicleService.swift
//  RentCar
//
//  Created by Jastin on 20/6/21.
//

import Foundation

class VehicleService: ServiceProtocol {
    
    func create(_ vm: Vehicle, completion: @escaping (Vehicle) -> ()) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.vehicle, model: vm, method: .post)) { data, res, error in
            if let data = data {
                if let vehicle = DataToObject<Vehicle>.decode(single: data) {
                    completion(vehicle)
                }
            }
        }
    }
    
    func update(_ vm: Vehicle) {
    
    }
    
    func getAll(completion: @escaping ([Vehicle]) -> ()) {
        APIService().request(url: URLRequestBuilder<Vehicle>().prepare(url: Constant.uRL.vehicle)) { data, res, error in
            if let data = data {
                if let vehicle = DataToObject<Vehicle>.decode(array: data) {
                    completion(vehicle)
                }
            }
        }
    }
    
    func remove(_ vm: Vehicle) {
    
    }
    
    typealias aType = Vehicle
    
    
}

