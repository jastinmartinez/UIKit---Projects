//
//  Mangament.swift
//  RentCar
//
//  Created by Jastin on 30/5/21.
//

import Foundation
import UIKit

struct Management {
    var name: String
    var image: String
    var segue: String
    var presenterType: PresenterTypeProtocol
}

let managementMenuData =
[
    Management(name: "Tipo Combustible", image: "combustible",segue: Constant.segue.maintenanceSegue, presenterType:  CombustibleTypePresenter()),
    Management(name: "Marca / Modelo Vehiculo", image: "mark",segue: Constant.segue.maintenanceSegue, presenterType: VehicleMarkPresenter()),
    Management(name: "Tipo Vehiculo", image: "type",segue: Constant.segue.maintenanceSegue, presenterType: VehicleTypePresenter()),
    Management(name: "Cliente", image: "customer",segue: Constant.segue.maintenanceSegue, presenterType: VehicleTypePresenter())
]

