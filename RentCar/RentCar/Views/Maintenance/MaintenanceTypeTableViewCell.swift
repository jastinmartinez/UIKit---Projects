//
//  CombustibleTypeTableViewCell.swift
//  RentCar
//
//  Created by Jastin on 31/5/21.
//

import UIKit

class MaintenanceTypeTableViewCell: UITableViewCell, BindOutletsProtocol {
    
    typealias aType = ModelType
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    
    func bindDataToOulets(vm: ModelType) {
        
        if vm is CombustibleType {
            
            let combustibleType = vm as! CombustibleType
            descriptionLabel.text = combustibleType.description
            stateLabel.text = combustibleType.state.ToStringState()
            
        }
        else if vm is VehicleMark {
            
            let vehicleMark = vm as! VehicleMark
            descriptionLabel.text = vehicleMark.description
            stateLabel.text = vehicleMark.state.ToStringState()
            
        }
        
        else if vm is VehicleType {
            
            let vehicleType = vm as! VehicleType
            descriptionLabel.text = vehicleType.description
            stateLabel.text = vehicleType.state.ToStringState()
            
        }
        
        else if vm is VehicleModel {
            
            let vehicleModel = vm as! VehicleModel
            descriptionLabel.text = vehicleModel.description
            stateLabel.text = vehicleModel.state.ToStringState()
        }
    }
}
