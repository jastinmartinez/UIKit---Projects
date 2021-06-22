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
    private(set) var vehicleModelsOfMark = [VehicleModel]()
    
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
    
    func getAllWithAvailableState() {
        vehicleModelService.getAll { vehicleModels in
            self.vehicleModelsOfMark = vehicleModels.filter({$0.state})
        }
    }
    
    func getModelsOfMarks(_ vm: UUID) {
        vehicleModelService.geModelsOfMark(VehicleMarkID: vm) { vehicleModels in
            self.vehicleModels = vehicleModels
        }
    }
    
    func getModelsOfMarks(_ vm: VehicleMark) {
        let temp = self.vehicleModelsOfMark
        self.vehicleModels = temp.filter{$0.vehicleMark.id == vm.id}
    }
    
    func getModelsOfMarks(for edit: VehicleMark,filter: (VehicleModel) -> (Bool)) {
        let temp = self.vehicleModelsOfMark
        self.vehicleModels = temp.filter(filter)
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
