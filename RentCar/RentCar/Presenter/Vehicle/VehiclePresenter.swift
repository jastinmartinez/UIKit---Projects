//
//  VehiclePresenter.swift
//  RentCar
//
//  Created by Jastin on 20/6/21.
//

import Foundation

class VehiclePresenter {
   
    typealias aType = Vehicle
    
    private var vehicleService = VehicleService()
    
    var vehicleViewDelegatePrtocol: VehicleViewDelegateProtocol?
    
    private(set) var _vehicles = [Vehicle]()
    
    private(set) var vehicles = [Vehicle]() {
        didSet {
            vehicleViewDelegatePrtocol?.didVehicleArrayChange()
        }
    }
    
    
    private func errorMesssage(title:String,message:String ) -> Bool {
        self.vehicleViewDelegatePrtocol?.didErrorOcurred(title: title, message: message)
        return true
    }
    
    fileprivate func dataValidation(_ vm: Vehicle,chasisNumber: @escaping (Vehicle) -> (Bool),plate: @escaping (Vehicle) -> (Bool),isValidation: @escaping (Bool) -> ()) {
        
        vehicleService.vehicleValidation(vm){ existVehicle in
            
            if !existVehicle.isEmpty {
                
                if existVehicle.filter(chasisNumber).count > 0 {
                    
                    isValidation(self.errorMesssage(title: "Vehiclo", message: "El No. de chasis \(vm.chasisNumber) se encuentra registrado"))
                }
                
                if existVehicle.filter(plate).count > 0 {
                    
                    isValidation(self.errorMesssage(title: "Vehiclo", message: "El No. de placa \(vm.plate) se encuentra registrado"))
                }
            }
            
            isValidation(false)
        }
    }
    
    func create(_ vm: Vehicle,notifyViewValidationStatus: @escaping (Bool) -> ()) {
        dataValidation(vm, chasisNumber: {$0.chasisNumber == vm.chasisNumber}, plate: {$0.plate == vm.plate}) { existVehicle in
            if !existVehicle {
                self.vehicleService.create(vm) { vehicle in
                    self.vehicles.append(vehicle)
                }
            }
            notifyViewValidationStatus(existVehicle)
        }
    }
    
    func getVehicleThatMatchInspectionDate(_ vm: [Vehicle]) {
        self.vehicles = vm
    }
    
    func getAllWithActiveStatus(completion: @escaping()->()) {
        vehicleService.getAll { vehicles in
            self._vehicles = vehicles
            self.vehicles = vehicles.filter({$0.state})
            completion()
        }
    }
    
    func getAll(completion: @escaping () -> ()) {
        vehicleService.getAll { vehicles in
            self.vehicles = vehicles
            completion()
        }
    }
    
    func update(_ vm: Vehicle,notifyViewValidationStatus: @escaping (Bool) -> ()) {
        dataValidation(vm, chasisNumber: {$0.chasisNumber == vm.chasisNumber && vm.id != $0.id}, plate: {$0.plate == vm.plate && vm.id != $0.id}) { existVehicle in
            if !existVehicle {
                self.vehicles[self.vehicles.firstIndex(where: {$0.id == vm.id})!] = vm
                self.vehicleService.update(vm)
            }
            notifyViewValidationStatus(existVehicle)
        }
    }
    
    func remove(for index: Int) {
        vehicleService.remove(vehicles[index])
        vehicles.remove(at: index)
    }
}
