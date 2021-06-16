//
//  VehicleMarkService.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation

class VehicleMarkService: ServiceProtocol {
    
    typealias aType = VehicleMark
    
    func create(_ vm: VehicleMark, completion: @escaping (VehicleMark) -> ()) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.vechileMark, addtionalHeaders: nil, model: vm, method: .post, requiredBearerToken: true)) { data, response, error in
            if let data = data {
                if let vehicleMark = DataToObject<VehicleMark>.decode(single: data) {
                    completion(vehicleMark)
                }
            }
        }
    }
    
    func update(_ vm: VehicleMark) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.vechileMark, addtionalHeaders: nil, model: vm, method: .put, requiredBearerToken: true)) {_,_,_ in}
    }
    
    func getAll(completion: @escaping ([VehicleMark]) -> ()) {
        APIService().request(url: URLRequestBuilder<VehicleMark>().prepare(url: Constant.uRL.vechileMark, addtionalHeaders: nil, requiredBearerToken: true)){ data,_,_ in
            if let data = data {
                if let vehicleMarks = DataToObject<VehicleMark>.decode(array: data) {
                    completion(vehicleMarks)
                }
            }
        }
    }
    
    func remove(_ vm: VehicleMark) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.vechileMark, addtionalHeaders: nil, model: vm, method: .delete, requiredBearerToken: true)) {_,_,_ in}
    }
    
}
