//
//  EmployeeTableViewController+TableView.swift
//  RentCar
//
//  Created by Jastin on 15/6/21.
//

import Foundation
import UIKit

extension EmployeeTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return employeePresenter.employees.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            employeePresenter.remove(indexPath.row)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.tableViewCell.employeeTableViewCell) as! EmployeeTableViewCell
        cell.bindDataToOulets(vm: employeePresenter.employees[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        performSegue(withIdentifier: Constant.segue.addOrEditEmployeeSegue, sender:  employeePresenter.employees[indexPath.row])
    }
}
