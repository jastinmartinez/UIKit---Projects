//
//  CombustibleTypeRepository.swift
//  RentCar
//
//  Created by Jastin on 25/5/21.
//

import Foundation

class CombustibleTypePresenter: PresenterTypeProtocol  {

    private var combustibleTypeService = CombustibleTypeService()
    
    static var shared: CombustibleTypePresenter = {
        let instance = CombustibleTypePresenter()
        return instance
    }()
    
    private(set) var combustibleTypes = [CombustibleType]() {
        didSet {
            self.combustibleTypeViewDelegate?.didArrayChange()
        }
    }
   
    var combustibleTypeViewDelegate: MaintenanceViewDelegateProtocol?
    
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
    func update(_ vm: CombustibleType) {
        combustibleTypes[combustibleTypes.firstIndex(where: {$0.id == vm.id})!] = vm
        self.combustibleTypeService.update(vm)
    }

    func remove(for index: Int)  {
        combustibleTypeService.Delete(vm: combustibleTypes[index])
        combustibleTypes.remove(at: index)
    }
}
