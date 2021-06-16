//
//  CustomerService.swift
//  RentCar
//
//  Created by Jastin on 6/6/21.
//

import Foundation

class CustomerService: ServiceProtocol {
    
    typealias aType = Customer
    
    func create(_ vm: Customer, completion: @escaping (Customer) -> ()) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.customer, model: vm, method: .post, requiredBearerToken: true)) { data, res, error in
            if let data = data {
                if let customer = DataToObject<Customer>.decode(single: data) {
                    completion(customer)
                }
            }
        }
    }
    
    func update(_ vm: Customer) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.customer, model: vm, method: .put, requiredBearerToken: true)) { _, _, _ in}
    }
    
    func getAll(completion: @escaping ([Customer]) -> ()) {
        APIService().request(url: URLRequestBuilder<Customer>().prepare(url: Constant.uRL.customer, requiredBearerToken: true)) { data, res, error in
            if let data = data {
                if let customers = DataToObject<Customer>.decode(array: data) {
                    completion(customers)
                }
            }
        }
    }
    
    func remove(_ vm: Customer) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.customer, model: vm, method: .delete, requiredBearerToken: true)) { _, _, _ in}
    }
    
    func verifyCustomerID(_ vm: Customer,completion: @escaping ([Customer]) -> ()) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.customerValidation, addtionalHeaders: nil, model: vm, method: .post, requiredBearerToken: true)) { data, res, error in
            if let data = data {
                if let customer = DataToObject<Customer>.decode(array: data) {
                    completion(customer)
                }
            }
        }
    }
}
