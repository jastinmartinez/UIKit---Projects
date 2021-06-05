//
//  CombustibleTypeRepository.swift
//  RentCar
//
//  Created by Jastin on 25/5/21.
//

import Foundation

class CombustibleTypePresenter  {
    
    
    private var combustibleTypeService: CombustibleTypeService
    private(set) var combustibleTypes = [CombustibleType]() {
        didSet {
            self.combustibleTypeViewDelegate?.didArrayOfCombustibleChange()
        }
    }
   
    init(service: CombustibleTypeService) {
        self.combustibleTypeService = service
    }
    
    var combustibleTypeViewDelegate: CombustibleTypeViewDelegate?
    
    func create(vm: CombustibleType) {
        combustibleTypeService.create(vm) { newCombustibleType in
            self.combustibleTypes.append(newCombustibleType)
        }
    }
    func getAll()  {
        combustibleTypeService.getAll() { arrayOfCombustibleType in
            self.combustibleTypes = arrayOfCombustibleType
        }
    }
    func update(vm: CombustibleType) {
        combustibleTypes[combustibleTypes.firstIndex(where: {$0.id == vm.id})!] = vm
        self.combustibleTypeService.update(vm)
    }

    func remove(for index: Int)  {
        combustibleTypeService.Delete(vm: combustibleTypes[index])
        combustibleTypes.remove(at: index)
    }
}
