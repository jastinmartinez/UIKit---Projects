//
//  RentTableTableViewCell.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import UIKit

class RentTableTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rentVehicleLabel: UILabel!
    @IBOutlet weak var rentCustomerLabel: UILabel!
    @IBOutlet weak var rentCustomerDateLabel: UILabel!
    @IBOutlet weak var rentDaysLabel: UILabel!
    @IBOutlet weak var RentTotalLabel: UILabel!
    @IBOutlet weak var RentPriceLabel: UILabel!
    @IBOutlet weak var rentStateLabel: UILabel!
    
    func bindDataToOulets(vm: (String,String,String,String,String,String,String)) {
        self.rentVehicleLabel.text = vm.0
        self.rentCustomerLabel.text = vm.1
        self.rentCustomerDateLabel.text = vm.2
        self.rentDaysLabel.text = vm.3
        self.RentTotalLabel.text = vm.4
        self.rentStateLabel.text = vm.5
        self.RentPriceLabel.text = vm.6
    }
}
