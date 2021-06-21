//
//  a.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation
import UIKit

extension MaintenanceViewController {
    
    func addNew()  {
        
        var alert = UIViewController()
        
        if self.presenterType is CombustibleTypePresenter {
            
            alert = AlertView().newItem(parameter: AddNewItemViewParameters(title: "Tipo Combustible", message: "Nuevo", placeholder: "Descripcion")) { value in
                
                let combustibleTypePresenter: CombustibleTypePresenter = self.presenterType as! CombustibleTypePresenter
                combustibleTypePresenter.create(vm:CombustibleType(description: value, state: true))
            }
            
        }
        
        else if self.presenterType is VehicleMarkPresenter {
            
            alert = AlertView().newItem(parameter: AddNewItemViewParameters(title: "Marca Vehiculo", message: "Nuevo", placeholder: "Descripcion")) { value in
                
                let vehicleMarkPresenter: VehicleMarkPresenter = self.presenterType as! VehicleMarkPresenter
                vehicleMarkPresenter.create(VehicleMark(description: value, state: true))
            }
        }
        
        else if self.presenterType is VehicleTypePresenter {
            
            alert = AlertView().newItem(parameter: AddNewItemViewParameters(title: "Tipo Vehiculo", message: "Nuevo", placeholder: "Descripcion")) { value in
                
                let vehicleTypePresenter: VehicleTypePresenter = self.presenterType as! VehicleTypePresenter
                vehicleTypePresenter.create(VehicleType(description: value, state: true))
            }
        }
        
        else if self.presenterType is VehicleModelPresenter {
            
            alert = AlertView().newItem(parameter: AddNewItemViewParameters(title: "Modelo Vehiculo", message: "Nuevo", placeholder: "Descripcion")) { value in
                
                let vehicleModelPresenter: VehicleModelPresenter = self.presenterType as! VehicleModelPresenter
                vehicleModelPresenter.create(VehicleModel(description: value, vehicleMark: ParentModel(id: (self.modelType as! VehicleMark).id), state: true))
            }
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}
