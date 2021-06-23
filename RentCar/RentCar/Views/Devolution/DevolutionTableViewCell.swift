//
//  DevolutionTableViewCell.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import UIKit

class DevolutionTableViewCell: UITableViewCell {

    @IBOutlet weak var DevolutionDaysLabel: UILabel!
    
    @IBOutlet weak var DevolutionCustomerLabel: UILabel!
    
    @IBOutlet weak var devolutionDateLabel: UILabel!
    @IBOutlet weak var DevolutionVehicleLabel: UILabel!
    
    @IBOutlet weak var DevolutionPriceLabel: UILabel!
    
    @IBOutlet weak var DevolutionTotalLabel: UILabel!
    
    func bindProperty(vm: (String,String,String,String,String,String)) {
       
        DevolutionDaysLabel.text = vm.0
        DevolutionCustomerLabel.text = vm.1
        DevolutionVehicleLabel.text = vm.2
        DevolutionPriceLabel.text = vm.3
        DevolutionTotalLabel.text = vm.4
        devolutionDateLabel.text = vm.5
    }
}
