//
//  InspectionService.swift
//  RentCar
//
//  Created by Jastin on 22/6/21.
//

import Foundation

final class InspectionService: ServiceProtocol
{
    func create(_ vm: Inspection, completion: @escaping (Inspection) -> ()) {
        APIService().request(url: URLRequestBuilder().prepare(url: Constant.uRL.inspection,model: vm, method: .post)) { data, res, error in
            if let data = data {
                if let inspection = DataToObject<Inspection>.decode(single: data) {
                    completion(inspection)
                }
            }
        }
    }
    
    func rentExist(_ vm: Inspection, completion: @escaping ([Inspection]) -> ()) {
        APIService().request(url: URLRequestBuilder<Inspection>().prepare(url: "\(Constant.uRL.inspection)/\(vm.id!)")) { data, res, error in
            if let data = data {
                if let inspection = DataToObject<Inspection>.decode(array: data) {
                    completion(inspection)
                }
            }
        }
    }
    
    func update(_ vm: Inspection) {
        APIService().request(url: URLRequestBuilder<Inspection>().prepare(url: Constant.uRL.inspection,model: vm,method: .put)) { _, _, _ in}
    }
    
    func getAll(completion: @escaping ([Inspection]) -> ()) {
        APIService().request(url: URLRequestBuilder<Inspection>().prepare(url: Constant.uRL.inspection)) { data, res, error in
            if let data = data {
                if let inspection = DataToObject<Inspection>.decode(array: data) {
                    completion(inspection)
                }
            }
        }
    }
    
    func remove(_ vm: Inspection) {
        APIService().request(url: URLRequestBuilder<Inspection>().prepare(url: Constant.uRL.inspection,model: vm,method: .delete)) { _, _, _ in}
    }
    
    typealias aType = Inspection
}
