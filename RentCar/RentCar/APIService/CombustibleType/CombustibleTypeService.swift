//
//  CombustibleTypeService.swift
//  RentCar
//
//  Created by Jastin on 30/5/21.
//

import Foundation


class CombustibleTypeService: ServiceProtocol  {

    func create(_ vm: CombustibleType, completion: @escaping (CombustibleType) -> () ) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.combustibleType, model: vm, method: .post, requiredBearerToken: true)) { data, response, _ in
            guard let data = data else {return}
            if let combustible = DataToObject<CombustibleType>.decode(single: data) {
                completion(combustible)
            }
        }
    }
    
    func update(_ vm: CombustibleType) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.combustibleType, model: vm, method: .put, requiredBearerToken: true)) { _,_,_ in}
    }
    
    func getAll(completion: @escaping ([CombustibleType]) -> ()) {
        APIService().request(url: URLRequestBuilder<CombustibleType>().prepare(url: Constant.uRL.combustibleType, requiredBearerToken: true)) { data, response,error in
            guard let data = data else {return}
            if let combustible = DataToObject<CombustibleType>.decode(array: data) {
                completion(combustible)
            }
        }
    }
    
    func remove(_ vm: CombustibleType) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.combustibleType, model: vm, method: .delete, requiredBearerToken: true)){ _,_,_ in}
    }
}
