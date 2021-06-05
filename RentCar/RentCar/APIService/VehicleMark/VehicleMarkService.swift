//
//  VehicleMarkService.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation

class VehicleMarkService: IService {
    
    typealias aType = VehicleMark
    
    func create(_ vm: VehicleMark, completion: @escaping (VehicleMark) -> ()) {
        APIService().request(url: RequestBuilder().prepare(url: Constant.uRL.vechileMark, header: nil, model: vm, method: .post, requiredBearerToken: true)) { data, response, error in
            if let data = data {
                if let vehicleMark = ObjectCodable<VehicleMark>.decode(single: data) {
                    completion(vehicleMark)
                }
            }
        }
    }
    
    func update(_ vm: VehicleMark) {
        APIService().request(url: RequestBuilder().prepare(url: Constant.uRL.vechileMark, header: nil, model: vm, method: .put, requiredBearerToken: true)) {_,_,_ in}
    }
    
    func getAll(completion: @escaping ([VehicleMark]) -> ()) {
        APIService().request(url: RequestBuilder<VehicleMark>().prepare(url: Constant.uRL.vechileMark, header: nil, requiredBearerToken: true)){ data,_,_ in
            if let data = data {
                if let vehicleMarks = ObjectCodable<VehicleMark>.decode(array: data) {
                    completion(vehicleMarks)
                }
            }
        }
    }
    
    func Delete(vm: VehicleMark) {
        APIService().request(url: RequestBuilder().prepare(url: Constant.uRL.vechileMark, header: nil, model: vm, method: .delete, requiredBearerToken: true)) {_,_,_ in}
    }
    
}
