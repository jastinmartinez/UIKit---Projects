//
//  InspectionTableViewCell.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import UIKit

class InspectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var inspectionVehicleLabel: UILabel!
    @IBOutlet weak var inspectionStateLabel: UILabel!
    
    func bindDataToOulets(vm: (String,Bool)) {
        self.inspectionVehicleLabel.text  = vm.0
        self.inspectionStateLabel.text = vm.1.ToStringStatus()
    }
}
