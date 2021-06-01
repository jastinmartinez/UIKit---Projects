//
//  CombustibleTypeRepository.swift
//  RentCar
//
//  Created by Jastin on 25/5/21.
//

import Foundation

class CombustibleTypePresenter {
    
    private var combustibleTypeService: CombustibleTypeService
   
    init(service: CombustibleTypeService) {
        
        self.combustibleTypeService = service
    }
    
    var delegate: CombustibleTypeViewDelegate?
    
    func create(vm: CombustibleType) {
        combustibleTypeService.create(vm) { _ in 
            
        }
    }
}
