//
//  ModifyCombustibleViewController.swift
//  RentCar
//
//  Created by Jastin on 3/6/21.
//

import Foundation
import UIKit

class ModifyCombustibleTypeViewController: UIViewController {
    
    @IBOutlet weak var modifiedCombustibleTypeDescriptionTextField: UITextField!
    @IBOutlet weak var modifiedCombustibleTypeStateSwitch: UISwitch!
    
    var combustibleTypePresenter: CombustibleTypePresenter!
    var combustibleType: CombustibleType!
    
    override func viewDidLoad() {
        didCombustibleTypeSelected(combustibleType)
        super.viewDidLoad()
    }
    
    @IBAction func modifyCombustibleTypeButtonPressed(_ sender: Any) {
        self.combustibleTypePresenter.update( vm: CombustibleType(id: combustibleType.id,description: modifiedCombustibleTypeDescriptionTextField.text!, state: modifiedCombustibleTypeStateSwitch.isOn))
        self.navigationController?.popViewController(animated: true) 
    }
    
    func didCombustibleTypeSelected(_ vm: CombustibleType) {
        self.modifiedCombustibleTypeDescriptionTextField.text = vm.description
        self.modifiedCombustibleTypeStateSwitch.isOn = vm.state
    }
}
