//
//  CombustibleTypeTableViewCell.swift
//  RentCar
//
//  Created by Jastin on 31/5/21.
//

import UIKit

class CombustibleTypeTableViewCell: UITableViewCell, BindOutlets {
    
    typealias aType = CombustibleType
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    
    func bindDataToOulets(vm: CombustibleType) {
    
        descriptionLabel.text = vm.description
        stateLabel.text = vm.state.ToString()
    }
}
