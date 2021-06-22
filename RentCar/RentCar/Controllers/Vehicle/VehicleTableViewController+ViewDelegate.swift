//
//  VehicleTableViewController+ViewDelegate.swift
//  RentCar
//
//  Created by Jastin on 21/6/21.
//

import Foundation

extension VehicleTableViewController: VehicleViewDelegateProtocol {
    
    func didVehicleArrayChange() {
        self.tableView.reloadData()
    }
    
    func didErrorOcurred(title: String, message: String) {
        present(AlertView().show(title: title, message: message),animated: true)
    }
}
