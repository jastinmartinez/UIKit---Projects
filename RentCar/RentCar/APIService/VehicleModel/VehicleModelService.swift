//
//  VehicleModelService.swift
//  RentCar
//
//  Created by Jastin on 6/6/21.
//

import Foundation

class VehicleModelService: ServiceProtocol {
  
    
    
    func create(_ vm: VehicleModel, completion: @escaping (VehicleModel) -> ()) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.vehicleModel, addtionalHeaders: nil, model: vm, method: .post, requiredBearerToken: true)) { data, res, error in
            if let data = data {
                if let vehicleModel = DataToObject<VehicleModel>.decode(single: data) {
                    completion(vehicleModel)
                }
            }
        }
    }
    
    func update(_ vm: VehicleModel) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.vehicleModel, addtionalHeaders: nil, model: vm, method: .put, requiredBearerToken: true)) { _, _, _ in}
    }
    
    func geModelsOfMark(VehicleMarkID: UUID,completion: @escaping ([VehicleModel]) -> ()) {
        APIService().request(url: URLRequestBuilder<VehicleModel>().prepare(url: "\(Constant.uRL.vehicleModel)/\(VehicleMarkID)", addtionalHeaders: nil, requiredBearerToken: true)) { data, res, Error in
            if let data = data {
                if let vehicleModels = DataToObject<VehicleModel>.decode(array: data) {
                    completion(vehicleModels)
                }
            }
        }
    }
    
    func getAll(completion: @escaping ([VehicleModel]) -> ()) {
        APIService().request(url: URLRequestBuilder<VehicleModel>().prepare(url: Constant.uRL.vehicleModel)) { data, res, error in
            if let data = data {
                if let vehicleModel = DataToObject<VehicleModel>.decode(array: data) {
                    completion(vehicleModel)
                }
            }
        }
    }
    
    func remove(_ vm: VehicleModel) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.vehicleModel, addtionalHeaders: nil, model: vm, method: .delete, requiredBearerToken: true)) { _, _, _ in}
    }
}
