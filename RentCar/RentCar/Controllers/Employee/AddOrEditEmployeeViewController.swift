//
//  AddOrEditEmployeeViewController.swift
//  RentCar
//
//  Created by Jastin on 15/6/21.
//

import UIKit

class AddOrEditEmployeeViewController: UIViewController {

    @IBOutlet weak var employeeNameTextField: UITextField!
    @IBOutlet weak var employeeJobShiftSegementedControl: UISegmentedControl!
    @IBOutlet weak var employeeStartDateDatePicker: UIDatePicker!
    @IBOutlet weak var employeeStateSwitch: UISwitch!
    @IBOutlet weak var employeeCommisionPercentTextField: UITextField!
    @IBOutlet weak var employeeIDTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func employeeSaveButtonPressed(_ sender: Any) {
        
    }
}
