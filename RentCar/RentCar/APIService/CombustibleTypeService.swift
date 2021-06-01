//
//  CombustibleTypeService.swift
//  RentCar
//
//  Created by Jastin on 30/5/21.
//

import Foundation


class CombustibleTypeService  {
    
    func create(_ vm: CombustibleType, completion: @escaping (CombustibleType) -> () ) {
        APIService().request(url: IRequestBuilder().prepare(url: Constant.uRL.combustibleType, model: vm, method: .post, requiredBearerToken: true)) { data, response, _ in
            if let combustibleType = ObjectCodable().decode(data) {
                
            }
        }
    }
    
    func update(_ vm: CombustibleType) {
        
    }
    
    func getAll() -> [CombustibleType] {
        return []
    }
}
