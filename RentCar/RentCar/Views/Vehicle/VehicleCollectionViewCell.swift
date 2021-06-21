//
//  VehicleTableViewCell.swift
//  RentCar
//
//  Created by Jastin on 21/6/21.
//

import UIKit

class VehicleCollectionViewCell: UICollectionViewCell,BindOutletsProtocol {
    
    @IBOutlet weak var vehicleDescriptionLabel: UILabel!
    
    func bindDataToOulets(vm: Vehicle) {
        self.vehicleDescriptionLabel.text = vm.description
    }
    
    typealias aType = Vehicle
}
