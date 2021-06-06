//
//  MaintenanceViewController+InitServices.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation
extension MaintenanceViewController {
    
    func initServices() {
        
        if presenterType is CombustibleTypePresenter {
            
            let combustibletypeService: CombustibleTypePresenter = presenterType as! CombustibleTypePresenter
            combustibletypeService.maintenanceViewDelegate = self
            combustibletypeService.getAll()
            
        }
        
        else if self.presenterType is VehicleMarkPresenter {
            
            let vehicleMarkService: VehicleMarkPresenter = presenterType as! VehicleMarkPresenter
            vehicleMarkService.maintenanceViewDelegate = self
            vehicleMarkService.getAll()
            
        }
        
        else if self.presenterType is VehicleTypePresenter {
            
            let vehicleTypePresenter: VehicleTypePresenter = presenterType as! VehicleTypePresenter
            vehicleTypePresenter.maintenanceViewDelegate = self
            vehicleTypePresenter.getAll()
            
        }
        
        else if self.presenterType is VehicleModelPresenter {
            
            let vehicleModelPresenter: VehicleModelPresenter = presenterType as! VehicleModelPresenter
            vehicleModelPresenter.maintenanceViewDelegate = self
            vehicleModelPresenter.getModelsOfMarks((modelType as! VehicleMark).id!)
            
        }
    }
}
