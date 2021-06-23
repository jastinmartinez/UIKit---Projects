//
//  RentTableTableViewCell.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import UIKit

class RentTableTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rentVehicleLabel: UILabel!
    @IBOutlet weak var rentStateLabel: UILabel!
    
    func bindDataToOulets(vm: (String,Bool)) {
        self.rentVehicleLabel.text = vm.0
        self.rentStateLabel.text = vm.1.ToStringStatus()
    }

}
