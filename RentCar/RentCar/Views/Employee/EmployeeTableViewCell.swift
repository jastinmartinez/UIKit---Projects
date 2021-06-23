//
//  EmployeeTableViewCell.swift
//  RentCar
//
//  Created by Jastin on 15/6/21.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell,BindOutletsProtocol {
   
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeStateLabel: UILabel!
    
    func bindDataToOulets(vm: Employee) {
        self.employeeNameLabel.text = vm.name
        self.employeeStateLabel.text = vm.state.ToStringState()
    }
    
    typealias aType = Employee

}
