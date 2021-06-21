//
//  ArrOrEditVehicleViewController.swift
//  RentCar
//
//  Created by Jastin on 20/6/21.
//

import Foundation
import UIKit

class AddOrEditVehicleViewController: UIViewController {
   
    @IBOutlet weak var vehicleDescriptionTextField: UITextField!
    @IBOutlet weak var vehicleEngineNumberTextField: UITextField!
    @IBOutlet weak var vehiclePlateTextField: UITextField!
    @IBOutlet weak var vehicleChasisNumberTextField: UITextField!
 
    @IBOutlet weak var vehicleVehicleTypePickerView: UIPickerView!
    @IBOutlet weak var vehicleVehicleMarkPickerView: UIPickerView!
    @IBOutlet weak var vehicleVehicleModelPickerView: UIPickerView!
    @IBOutlet weak var vehicleCombustibleTypePickerView: UIPickerView!
    
    @IBOutlet weak var vehicleDescriptionErrorLabel: UILabel!
    @IBOutlet weak var vehicleChasisNumberErrorLabel: UILabel!
    @IBOutlet weak var vehicleEngineNumberErrorLabel: UILabel!
    @IBOutlet weak var vehiclePlateErroLabel: UILabel!
    
    
    var vehiclePresenter: VehiclePresenter?
    var vehicleTypePresenter = VehicleTypePresenter()
    var vehicleModelPresenter = VehicleModelPresenter()
    var vehicleMarkPresenter = VehicleMarkPresenter()
    var combustibleTypePresenter = CombustibleTypePresenter()
    
    var vehicleTypeID: UUID?
    var vehicleMarkID: UUID?
    var vehicleModelID: UUID?
    var combustibleTypeID: UUID?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewDidLoad()
        initValidation()
    }
    
    
    @IBAction func vehicleSavedButtonPressed(_ sender: Any) {
        isInputValidationComplete { isValidationComplete in
            if isValidationComplete {
                vehiclePresenter?.create(Vehicle(description: vehicleDescriptionTextField.text!, chasisNumber: vehicleChasisNumberTextField.text!, engineNumber: vehicleEngineNumberTextField.text!, plate: vehiclePlateTextField.text!, vehicleType: ParentModel(id: vehicleTypeID), vehicleMark: ParentModel(id: vehicleMarkID), vehicleModel: ParentModel(id: vehicleModelID), combustibleType: ParentModel(id: combustibleTypeID), state: true))
            }
        }
    }
    
    func initViewDidLoad() {
        
        self.vehicleModelPresenter.getAllWithAvailableState()
        self.vehicleModelPresenter.maintenanceViewDelegate = self
        
        self.vehicleMarkPresenter.getAllWithAvailableState()
        self.vehicleMarkPresenter.maintenanceViewDelegate = self
        
        self.vehicleTypePresenter.getAllWithAvailableState()
        self.vehicleTypePresenter.maintenanceViewDelegate = self
        
        self.combustibleTypePresenter.getAllWithAvailableState()
        self.combustibleTypePresenter.maintenanceViewDelegate = self
    }
}
