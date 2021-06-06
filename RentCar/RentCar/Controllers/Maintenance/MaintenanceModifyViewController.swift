//
//  ModifyCombustibleViewController.swift
//  RentCar
//
//  Created by Jastin on 3/6/21.
//

import Foundation
import UIKit

class MaintenanceModifyViewController: UIViewController {
    
    @IBOutlet weak var modifiedMaintenanceDescriptionTextField: UITextField!
    @IBOutlet weak var modifiedMaintenanceStateSwitch: UISwitch!
    
    var presenterType: PresenterTypeProtocol!
    
    var modelType: ModelType!
    
    override func viewDidLoad() {
        
        didCombustibleTypeSelected(modelType)
        super.viewDidLoad()
    }
    
    @IBAction func modifyCombustibleTypeButtonPressed(_ sender: Any) {
        
        if presenterType is CombustibleTypePresenter {
            
            let combustibleTypePresenter: CombustibleTypePresenter = presenterType as! CombustibleTypePresenter
            combustibleTypePresenter.update(CombustibleType(id: (modelType as! CombustibleType).id, description: modifiedMaintenanceDescriptionTextField.text!, state: modifiedMaintenanceStateSwitch.isOn))
            
        } else if presenterType is VehicleMarkPresenter {
    
            let vehicleMarkerPresenter: VehicleMarkPresenter = presenterType as! VehicleMarkPresenter
            vehicleMarkerPresenter.update(VehicleMark(id: (modelType as! VehicleMark).id, description: modifiedMaintenanceDescriptionTextField.text!, state: modifiedMaintenanceStateSwitch.isOn))
        }
        
        else if presenterType is VehicleTypePresenter {
    
            let vehicleTypePresenter: VehicleTypePresenter = presenterType as! VehicleTypePresenter
            vehicleTypePresenter.update(VehicleType(id: (modelType as! VehicleType).id, description: modifiedMaintenanceDescriptionTextField.text!, state: modifiedMaintenanceStateSwitch.isOn))
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func didCombustibleTypeSelected(_ vm: ModelType) {
        
        if vm is CombustibleType {
            
            let combustibleType: CombustibleType = vm as! CombustibleType
            self.modifiedMaintenanceDescriptionTextField.text = combustibleType.description
            self.modifiedMaintenanceStateSwitch.isOn = combustibleType.state
            
        }
        else if vm is VehicleMark {
            
            let vehicleMark: VehicleMark = vm as! VehicleMark
            self.modifiedMaintenanceDescriptionTextField.text = vehicleMark.description
            self.modifiedMaintenanceStateSwitch.isOn = vehicleMark.state
            
        }
        
        else if vm is VehicleType {
            
            let vehicleType: VehicleType = vm as! VehicleType
            self.modifiedMaintenanceDescriptionTextField.text = vehicleType.description
            self.modifiedMaintenanceStateSwitch.isOn = vehicleType.state
            
        }
    }
}
