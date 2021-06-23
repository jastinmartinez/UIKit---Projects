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
    Management(name: "Vehiculo", image: "honda",segue: Constant.segue.vehicleSegue, presenterType: EmployeePresenter()),
    Management(name: "Cliente", image: "customer",segue: Constant.segue.customerSegue, presenterType: CustomerPresenter()),
    Management(name: "Empleado", image: "employee",segue: Constant.segue.employeeSegue, presenterType: EmployeePresenter()),
    Management(name: "Inspeccion", image: "inspection",segue: Constant.segue.inspectionSegue, presenterType: InspectionPresenter()),
    Management(name: "Renta", image: "rent",segue: Constant.segue.rentSegue, presenterType: RentPresenter()),
    Management(name: "Devolucion", image: "devolution",segue: Constant.segue.devolutionSegue, presenterType: DevolutionPresenter()),
]

