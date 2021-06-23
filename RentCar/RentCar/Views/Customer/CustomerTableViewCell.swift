//
//  CustomerTableViewCell.swift
//  RentCar
//
//  Created by Jastin on 8/6/21.
//

import UIKit

class CustomerTableViewCell: UITableViewCell,BindOutletsProtocol {
   
    @IBOutlet weak var customerStateTextField: UILabel!
    @IBOutlet weak var customerNameTextField: UILabel!
    
    func bindDataToOulets(vm: Customer) {
        self.customerNameTextField.text = vm.name
        self.customerStateTextField.text = vm.state.ToStringState()
    }
    
    typealias aType = Customer
}
