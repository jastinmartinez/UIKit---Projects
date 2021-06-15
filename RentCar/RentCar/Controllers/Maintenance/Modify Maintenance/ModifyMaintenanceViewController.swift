//
//  ModifyCombustibleViewController.swift
//  RentCar
//
//  Created by Jastin on 3/6/21.
//

import Foundation
import UIKit

class ModifyMaintenanceViewController: UIViewController {
    
    @IBOutlet weak var modifiedMaintenanceDescriptionTextField: UITextField!
    @IBOutlet weak var modifiedMaintenanceStateSwitch: UISwitch!
    
    var presenterType: PresenterTypeProtocol!
    
    var modelType: ModelType!
    
    override func viewDidLoad() {
        
        didItemSelected(modelType)
        super.viewDidLoad()
    }
    
    @IBAction func maintenanceModifySaveButtonPressed(_ sender: Any) {
        
       modifyItem()
    }
    
}
