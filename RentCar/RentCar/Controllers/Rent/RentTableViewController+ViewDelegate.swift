//
//  RentTableViewController+ViewDelegate.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import Foundation
extension RentTableViewController: rentViewDelegateProtocol {
    
    func didArrayChange() {
        
        vehicleJoinRent = []
        vehicleJoinInspection = []
        customersJoinRent = []
        
        for rent in rentPresenter.rents {
            
            if let vehicle = vehiclePresenter._vehicles.first(where: {$0.id == rent.vehicle.id}) {
                
                vehicleJoinRent.append(vehicle)
            }
            
            if let customer = customerPresenter._customers.first(where: {$0.id == rent.customer.id}) {
                
                customersJoinRent.append(customer)
            }
        }
        
        for inspetion in inspectionPresenter.inspections {
            
            if inspetion.date >= Date().toString() {
                
                if let vehicle = vehiclePresenter.vehicles.first(where: {$0.id == inspetion.vehicle.id}) {
                   
                    vehicleJoinInspection.append(vehicle)
                }
            }
        }
        
        vehiclePresenter.getVehicleThatMatchInspectionDate(vehicleJoinInspection) 
        self.tableView.reloadData()
    }
}
