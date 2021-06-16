//
//  EmployeeTableViewController+TableView.swift
//  RentCar
//
//  Created by Jastin on 15/6/21.
//

import Foundation
import UIKit

extension EmployeeTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return employeePresenter.employees.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.tableViewCell.employeeTableViewCell) as! EmployeeTableViewCell
        cell.bindDataToOulets(vm: employeePresenter.employees[indexPath.row])
        return cell
    }
}
