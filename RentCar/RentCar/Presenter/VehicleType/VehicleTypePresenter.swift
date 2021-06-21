//
//  VehicleTypePresenter.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation

class VehicleTypePresenter: PresenterProtocol,PresenterTypeProtocol {
    
    typealias aType = VehicleType
    
    private var vehicleTypeService: VehicleTypeService!
    
    var maintenanceViewDelegate: MaintenanceViewDelegateProtocol?
    
    private(set) var vehicleTypes = [VehicleType]() {
        didSet {
            self.maintenanceViewDelegate?.didArrayChange()
        }
    }
    
    init() {
        self.vehicleTypeService = VehicleTypeService()
    }
    
    func create(_ vm: VehicleType) {
        vehicleTypeService.create(vm) { vehicleType in
            self.vehicleTypes.append(vehicleType)
        }
    }
    
    func getAll() {
        vehicleTypeService.getAll { vehicleTypes in
            self.vehicleTypes = vehicleTypes
        }
    }
    func getAllWithAvailableState() {
        vehicleTypeService.getAll { vehicleTypes in
            self.vehicleTypes = vehicleTypes.filter({$0.state})
        }
    }
    
    func update(_ vm: VehicleType) {
        vehicleTypeService.update(vm)
        vehicleTypes[vehicleTypes.firstIndex(where: {$0.id == vm.id})!] = vm
    }
    
    func remove(for index: Int) {
        vehicleTypeService.remove(vehicleTypes[index])
        vehicleTypes.remove(at: index)
    }
}
