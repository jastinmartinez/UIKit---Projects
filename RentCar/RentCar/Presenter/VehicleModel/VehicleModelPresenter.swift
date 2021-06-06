//
//  VehicleModelPresente.swift
//  RentCar
//
//  Created by Jastin on 6/6/21.
//

import Foundation

class VehicleModelPresenter: PresenterTypeProtocol {
    
    private var vehicleModelService: VehicleModelService!
    
    init() {
        vehicleModelService = VehicleModelService()
    }
    
    private(set) var vehicleModels = [VehicleModel]() {
        
        didSet {
            self.maintenanceViewDelegate?.didArrayChange()
        }
    }
    var maintenanceViewDelegate: MaintenanceViewDelegateProtocol?
    
    typealias aType = VehicleModel
    
    func create(_ vm: VehicleModel) {
        vehicleModelService.create(vm) { vehicleModel in
            self.vehicleModels.append(vm)
        }
    }
    
    func getModelsOfMarks(_ vm: UUID) {
        vehicleModelService.geModelsOfMark(VehicleMarkID: vm) { vehicleModels in
            self.vehicleModels = vehicleModels
        }
    }
    
    func update(_ vm: VehicleModel) {
        vehicleModels[vehicleModels.firstIndex(where: {$0.id == vm.id})!] = vm
        vehicleModelService.update(vm)
    }
    
    func remove(for index: Int) {
        vehicleModelService.remove(vehicleModels[index])
        vehicleModels.remove(at: index)
    }
}
