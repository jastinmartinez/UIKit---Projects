//
//  InspectionTableViewController+ViewDelegate.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import Foundation

extension InspectionTableViewController: InspectionViewdelegateProtocol ,VehicleViewDelegateProtocol {
    
    
    func didErrorOcurred(title: String, message: String) {
        
        present(AlertView().show(title: title, message: message), animated: true, completion: nil)
    }
    
    func didVehicleArrayChange() {
        
            self.tableView.reloadData()
    }
    
    func didInspectionsChange() {
        
        vehiclesJoinInspection = []
        
        for inspection in self.inspectionPresenter.inspections {
            
            if let vehicle = self.vehiclePresenter._vehicles.first(where: {$0.id == inspection.vehicle.id}) {
                
                self.vehiclesJoinInspection.append(vehicle)
            }
        }
        
        self.tableView.reloadData()
    }
}
