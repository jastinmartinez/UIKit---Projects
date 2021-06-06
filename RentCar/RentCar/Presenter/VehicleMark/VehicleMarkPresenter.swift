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
    
    private(set) var vehicleMarks = [VehicleMark]() {
        didSet {
            maintenanceViewDelegate?.didArrayChange()
        }
    }
    
    static var shared: VehicleMarkPresenter = {
       let instance = VehicleMarkPresenter()
        return instance
    }()
    
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
    
    func update(_ vm: VehicleMark) {
        vehicleMarks[vehicleMarks.firstIndex(where: {$0.id == vm.id})!] = vm
        vehicleMarkService.update(vm)
    }
    
    func remove(for index: Int) {
        vehicleMarkService.Delete(vm: vehicleMarks[index])
        vehicleMarks.remove(at: index)
    }
}
