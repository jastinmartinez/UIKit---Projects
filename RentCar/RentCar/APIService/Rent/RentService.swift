//
//  RentService.swift
//  RentCar
//
//  Created by Jastin on 22/6/21.
//

import Foundation
final class RentService: ServiceProtocol {
    
    func create(_ vm: Rent, completion: @escaping (Rent) -> ()) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.rent, model: vm, method: .post)) { data, res, error in
            if let data = data {
                if let rent = DataToObject<Rent>.decode(single: data) {
                    completion(rent)
                }
            }
        }
    }
    
    func update(_ vm: Rent) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.rent, model: vm, method: .put)) { data, res, error in}
    }
    
    func getAll(completion: @escaping ([Rent]) -> ()) {
        APIService().request(url: URLRequestBuilder<Rent>().prepare(url: Constant.uRL.rent)) { data, res, error in
            if let data = data {
                if let rent = DataToObject<Rent>.decode(array: data) {
                    completion(rent)
                }
            }
        }
    }
    
    func remove(_ vm: Rent) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.rent, model: vm, method: .delete)) { data, res, error in}
    }
    
    typealias aType = Rent
    
    
}
