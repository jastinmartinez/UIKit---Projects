//
//  VehicleTypeService.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation
import Alamofire
class VehicleTypeService : ServiceProtocol {
    
    typealias aType = VehicleType
    
    func create(_ vm: VehicleType, completion: @escaping (VehicleType) -> ()) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.vehicleType, addtionalHeaders: nil, model: vm, method: .post, requiredBearerToken: true)) { data, response, error in
            if let data = data {
                if let vehicleType = DataToObject<VehicleType>.decode(single: data) {
                    completion(vehicleType)
                }
            }
        }
    }
    
    func update(_ vm: VehicleType) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.vehicleType, addtionalHeaders: nil, model: vm, method: .put, requiredBearerToken: true)) { _, _, _ in
        }
    }
    
    func getAll(completion: @escaping ([VehicleType]) -> ()) {
        APIService().request(url: URLRequestBuilder<VehicleType>().prepare(url: Constant.uRL.vehicleType, addtionalHeaders: nil, requiredBearerToken: true)) { data, res, error in
            if let data = data {
                if let vehicleTypes = DataToObject<VehicleType>.decode(array: data) {
                    completion(vehicleTypes)
                }
            }
        }
    }
    
    func remove(_ vm: VehicleType) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.vehicleType, addtionalHeaders: nil, model: vm, method: .delete, requiredBearerToken: true)) { _, _, _ in
        }
    }
}
