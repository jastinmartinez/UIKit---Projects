//
//  CombustibleTypeRepository.swift
//  RentCar
//
//  Created by Jastin on 25/5/21.
//

import Foundation

class CombustibleTypePresenter: PresenterTypeProtocol  {

    private var combustibleTypeService = CombustibleTypeService()
    
    private(set) var combustibleTypes = [CombustibleType]() {
        didSet {
            self.maintenanceViewDelegate?.didArrayChange()
        }
    }
   
    var maintenanceViewDelegate: MaintenanceViewDelegateProtocol?
    
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
    func getAllWithAvailableState()  {
        combustibleTypeService.getAll() { arrayOfCombustibleType in
            self.combustibleTypes = arrayOfCombustibleType.filter({$0.state})
        }
    }
    func update(_ vm: CombustibleType) {
        combustibleTypes[combustibleTypes.firstIndex(where: {$0.id == vm.id})!] = vm
        self.combustibleTypeService.update(vm)
    }

    func remove(for index: Int)  {
        combustibleTypeService.remove(combustibleTypes[index])
        combustibleTypes.remove(at: index)
    }
}
