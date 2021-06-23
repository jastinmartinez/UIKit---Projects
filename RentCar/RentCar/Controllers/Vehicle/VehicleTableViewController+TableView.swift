//
//  VehicleTableViewController+TableView.swift
//  RentCar
//
//  Created by Jastin on 21/6/21.
//

import Foundation
import UIKit

extension VehicleTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return vehiclePresenter.vehicles.count
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        performSegue(withIdentifier: Constant.segue.addOrEditVehicleSegue, sender: (vehicle:vehiclePresenter.vehicles[indexPath.row],true))
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        performSegue(withIdentifier: Constant.segue.addOrEditVehicleSegue, sender: (vehicle: vehiclePresenter.vehicles[indexPath.row],isViewOnly:false))
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            vehiclePresenter.remove(for: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.accessoryType = .detailButton
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return {
            let cell = (tableView.dequeueReusableCell(withIdentifier: Constant.tableViewCell.vehicleTableViewCell, for: indexPath) as! VehicleTableViewCell)
             cell.bindDataToOulets(vm: vehiclePresenter.vehicles[indexPath.row])
             return cell
        }()
    }
    
}
