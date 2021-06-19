//
//  EmployeeService.swift
//  RentCar
//
//  Created by Jastin on 15/6/21.
//

import Foundation

class EmployeeService: ServiceProtocol {
    
    func create(_ vm: Employee, completion: @escaping (Employee) -> ()) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.employee, addtionalHeaders: nil, model: vm, method: .post, requiredBearerToken: true)) { data, res, error in
            if let data = data {
                if let employee = DataToObject<Employee>.decode(single: data) {
                    completion(employee)
                }
            }
        }
    }
    
    func update(_ vm: Employee) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.employee, model: vm, method: .put)) { _, _, _ in}
    }
    
    func getAll(completion: @escaping ([Employee]) -> ()) {
        APIService().request(url: URLRequestBuilder<Employee>().prepare(url: Constant.uRL.employee)) { data, res, error in
            if let data = data {
                if let employee = DataToObject<Employee>.decode(array: data) {
                    completion(employee)
                }
            }
        }
    }
    
    func remove(_ vm: Employee) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.employee, model: vm, method: .delete)) { _, _, _ in}
    }
    
    func verifyEmployeeID(_ vm: Employee,completion: @escaping ([Employee]) -> ()) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.employeeValidation, model: vm, method: .post)) { data, res, error in
            if let data = data {
                if let employee = DataToObject<Employee>.decode(array: data) {
                    completion(employee)
                }
            }
        }
    }
    
    typealias aType = Employee
}
