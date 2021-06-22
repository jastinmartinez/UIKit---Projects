//
//  AddOrEditVehicleViewController+EditOnly.swift
//  RentCar
//
//  Created by Jastin on 22/6/21.
//

import Foundation
import UIKit

extension AddOrEditVehicleViewController {
    
    func initEditOnly() {
        
        if let isViewOnly = isViewOnly, let vehicle = vehicle {
            
            if isViewOnly == false  {
                
                self.title = "Editar"
                
                vehicleModelToOutlets(vehicle)
                
                EnableOrDisableOutlets().switchs(switchs: vehicleStateSwitch)
            }
        }
    }
}
