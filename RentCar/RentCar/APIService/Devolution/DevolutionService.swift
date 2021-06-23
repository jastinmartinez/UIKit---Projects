//
//  DevolutionService.swift
//  RentCar
//
//  Created by Jastin on 22/6/21.
//

import Foundation

final class DevolutionService: ServiceProtocol
{
    func create(_ vm: Devolution, completion: @escaping (Devolution) -> ()) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.devolution,model: vm, method: .post)) { data, res, error in
            if let data = data {
                if let devolution = DataToObject<Devolution>.decode(single: data) {
                    completion(devolution)
                }
            }
        }
    }
    
    func update(_ vm: Devolution) {
        APIService().request(url: URLRequestBuilder<Devolution>().prepare(url: Constant.uRL.devolution,model: vm,method: .put)) { _, _, _ in}
    }
    
    func getAll(completion: @escaping ([Devolution]) -> ()) {
        APIService().request(url: URLRequestBuilder<Devolution>().prepare(url: Constant.uRL.devolution)) { data, res, error in
            if let data = data {
                if let devolution = DataToObject<Devolution>.decode(array: data) {
                    completion(devolution)
                }
            }
        }
    }
    
    func remove(_ vm: Devolution) {
        APIService().request(url: URLRequestBuilder<Devolution>().prepare(url: Constant.uRL.devolution,model: vm,method: .delete)) { _, _, _ in}
    }
    
    typealias aType = Devolution
}
