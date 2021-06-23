//
//  VehicleTableViewCell.swift
//  RentCar
//
//  Created by Jastin on 21/6/21.
//

import UIKit

class VehicleTableViewCell: UITableViewCell,BindOutletsProtocol {
    
    @IBOutlet weak var vehicleDescriptionLabel: UILabel!
    @IBOutlet weak var vehicleStateLabel: UILabel!
    
    func bindDataToOulets(vm: Vehicle) {
        self.vehicleDescriptionLabel.text = vm.description
        self.vehicleStateLabel.text = vm.state.ToStringState()
    }
    
    typealias aType = Vehicle
}
