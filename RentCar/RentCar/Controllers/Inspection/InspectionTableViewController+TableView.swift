//
//  InspectionTableViewController+TableView.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import Foundation
import UIKit

extension InspectionTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return inspectionPresenter.inspections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.tableViewCell.inspectionTableViewCell) as! InspectionTableViewCell
       
        cell.bindDataToOulets(vm:( (  vehiclesJoinInspection.count > 0 ? vehiclesJoinInspection[indexPath.row].description : "\(vehiclesJoinInspection[indexPath.row].description) - INACTIVO" ,inspectionPresenter.inspections[indexPath.row].date >= Date().toString() ? inspectionPresenter.inspections[indexPath.row].state : false)))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == .delete {
        
            inspectionPresenter.remove(for: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if inspectionPresenter.inspections[indexPath.row].date >= Date().toString() {
            performSegue(withIdentifier: Constant.segue.addOrEditInspectionSegue, sender: (inspectionPresenter.inspections[indexPath.row],false))
        }
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        performSegue(withIdentifier: Constant.segue.addOrEditInspectionSegue, sender: (inspectionPresenter.inspections[indexPath.row],true))
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryType = .detailButton
    }
}
