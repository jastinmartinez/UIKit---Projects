//
//  VehiclePresenter.swift
//  RentCar
//
//  Created by Jastin on 20/6/21.
//

import Foundation

class VehiclePresenter: PresenterProtocol {
    
    typealias aType = Vehicle
    
    private var vehicleService = VehicleService()
    
    var vehicleViewDelegatePrtocol: VehicleViewDelegateProtocol?
    
    private(set) var vehicles = [Vehicle]() {
        didSet {
            vehicleViewDelegatePrtocol?.didVehicleArrayChange()
        }
    }
    
    
    private func errorMesssage(title:String,message:String ) -> Bool {
        self.vehicleViewDelegatePrtocol?.didErrorOcurred(title: title, message: message)
        return true
    }
    
    fileprivate func employeeDataValidation(_ vm: Employee,iDFilters: @escaping (Employee) -> (Bool),isValidation: @escaping (Bool) -> ()) {
        
        employeeService.verifyEmployeeID(vm) { existEmployee in
            
            if !existEmployee.isEmpty {
                if existEmployee.filter(iDFilters).count > 0 {
                    isValidation(self.errorMesssage(title: "Empleado", message: "La Cedula \(vm.employeeID) se encuentra registrada"))
                }
            }
            isValidation(false)
        }
    }
    
    func create(_ vm: Vehicle) {
        vehicleService.create(vm) { vehicle in
            self.vehicles.append(vehicle)
        }
    }
    
    func getAll() {
        vehicleService.getAll { vehicles in
            self.vehicles = vehicles
        }
    }
    
    func update(_ vm: Vehicle) {
        
    }
    
    func remove(for index: Int) {
        
    }
    
   
}
