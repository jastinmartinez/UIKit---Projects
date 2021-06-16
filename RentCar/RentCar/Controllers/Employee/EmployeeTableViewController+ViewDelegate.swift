//
//  EmployeeTableViewController+NotifyView.swift
//  RentCar
//
//  Created by Jastin on 15/6/21.
//

import Foundation
extension EmployeeTableViewController: EmployeeViewDelegateProtocol {
    
    func didEmployeesChange() {
        tableView.reloadData()
    }
    
    func didErrorOcurred(title: String, message: String) {
        present(AlertView().show(title: title, message: message),animated: true)
    }
}
