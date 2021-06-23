//
//  RentTableViewController+TableView.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import Foundation
import UIKit

extension RentTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rentPresenter.rents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.tableViewCell.rentTableViewCell) as! RentTableTableViewCell
        
        cell.bindDataToOulets(vm: (vehicleJoinRent.count > 0 ? vehicleJoinRent[indexPath.row].description : "\(vehicleJoinRent[indexPath.row].description) - INACTIVO",
                                   customersJoinRent[indexPath.row].name,
                                   rentPresenter.rents[indexPath.row].date,
                                   rentPresenter.rents[indexPath.row].amountOfDay.toString(),
                                   Int(rentPresenter.rents[indexPath.row].amountOfDay * Int.init(rentPresenter.rents[indexPath.row].amountPerDay)).toString(),
                                   rentPresenter.rents[indexPath.row].state.ToStringStatus(),
                                   rentPresenter.rents[indexPath.row].amountPerDay.ToString()))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryType = .detailButton
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        performSegue(withIdentifier: Constant.segue.addOrEditRentSegue, sender: (rentPresenter.rents[indexPath.row],true))
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if rentPresenter.rents[indexPath.row].state {
            
            performSegue(withIdentifier: Constant.segue.addOrEditRentSegue, sender: (rentPresenter.rents[indexPath.row],false))
            
        }
    }
    
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == .delete {
        
            rentPresenter.remove(for: indexPath.row)
        }
    }
}
