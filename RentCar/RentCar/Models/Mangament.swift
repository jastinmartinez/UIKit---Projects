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
    Management(name: "Tipo Combustible", image: "combustible",segue: "maintenanceSegue", presenterType:  CombustibleTypePresenter()),
    Management(name: "Marca Vehiculo", image: "mark",segue: "maintenanceSegue", presenterType: VehicleMarkPresenter()),
    Management(name: "Tipo Vehiculo", image: "type",segue: "maintenanceSegue", presenterType: VehicleTypePresenter())
]

