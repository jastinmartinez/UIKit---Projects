//
//  VehicleMarkPresenter.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation

class VehicleMarkPresenter: PresenterProtocol,PresenterTypeProtocol {
    
    var maintenanceViewDelegate: MaintenanceViewDelegateProtocol?
    
    typealias aType = VehicleMark
    
    private var vehicleMarkService = VehicleMarkService()
    private var vehicleModelService = VehicleModelService()
    
    private(set) var vehicleMarks = [VehicleMark]() {
        didSet {
            maintenanceViewDelegate?.didArrayChange()
        }
    }
    
    func create(_ vm: VehicleMark) {
        vehicleMarkService.create(vm) { vehicleMark in
            self.vehicleMarks.append(vehicleMark)
        }
    }
    
    func getAll() {
        vehicleMarkService.getAll { vehicleMarks in
            self.vehicleMarks = vehicleMarks
        }
    }
    func getAllWithAvailableState() {
        vehicleMarkService.getAll { vehicleMarks in
            self.vehicleMarks = vehicleMarks.filter({$0.state})
        }
    }
    
    func update(_ vm: VehicleMark) {
        vehicleMarks[vehicleMarks.firstIndex(where: {$0.id == vm.id})!] = vm
        vehicleMarkService.update(vm)
    }
    
    func remove(for index: Int) {
        vehicleModelService.geModelsOfMark(VehicleMarkID: vehicleMarks[index].id!) { modelsOfMark in
            if modelsOfMark.count == 0 {
                self.vehicleMarkService.remove(self.vehicleMarks[index])
                self.vehicleMarks.remove(at: index)
            }
            else {
                self.maintenanceViewDelegate?.didErrorOcurred(title: "Marca Vehiculo", message: "\(self.vehicleMarks[index].description) no puede ser eliminada existen modelos vinculados")
            }
        }
    }
}
