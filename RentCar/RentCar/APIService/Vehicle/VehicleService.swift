//
//  VehicleService.swift
//  RentCar
//
//  Created by Jastin on 20/6/21.
//

import Foundation

class VehicleService: ServiceProtocol {

    typealias aType = Vehicle
    
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
        
        APIService().request(url: URLRequestBuilder<Vehicle>().prepare(url: Constant.uRL.vehicle,model: vm,method: .put)) { _, _, _ in }
            
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
        
        APIService().request(url: URLRequestBuilder<Vehicle>().prepare(url: Constant.uRL.vehicle,model: vm,method: .delete)) { _, _, _ in }
    }
    
    func vehicleValidation(_ vm: Vehicle,completion: @escaping ([Vehicle]) -> ()) {
        
        APIService().request(url: URLRequestBuilder<Vehicle>().prepare(url: Constant.uRL.vehicleValidation,model: vm,method: .post)) { data, res, error in
            if let data = data {
                if let vehicle = DataToObject<Vehicle>.decode(array: data) {
                    completion(vehicle)
                }
            }
        }
    }
    
}

