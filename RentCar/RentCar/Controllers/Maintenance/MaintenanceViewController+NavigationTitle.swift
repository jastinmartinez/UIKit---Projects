//
//  MaintenanceViewController+NavigationTitle.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation
extension MaintenanceViewController {
    func setViewControllerTitle()  {
        if presenterType is CombustibleTypePresenter {
            self.title = "Tipo Combustible"
        } else if presenterType is VehicleMarkPresenter {
            self.title = "Marca Vehiclo"
        }
    }
}
