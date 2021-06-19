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
    @IBOutlet weak var employeeCommisionPercentErrorLabel: UILabel!
    @IBOutlet weak var employeeNameErrorLabel: UILabel!
    @IBOutlet weak var employeeIDErrorLabel: UILabel!
    
    var employeePresenter = EmployeePresenter.shared
    
    private var employeeJobShift: String!
    private var employeeStartedDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewDidiLoad()
    }
    
    func initViewDidiLoad()
    {
        initOutletsValidationEvent()
        employeeJobShift = employeeJobShiftSegementedControl.titleForSegment(at: 0)
        employeeStartedDate = employeeStartDateDatePicker.date
    }
    
    @IBAction func employeeJobShiftSegmentedControlValueChanged(_ sender: Any) {
        
        employeeJobShift = employeeJobShiftSegementedControl.titleForSegment(at: self.employeeJobShiftSegementedControl.selectedSegmentIndex)
    }
    
    @IBAction func employeeStartedDateDatePickerValueChanged(_ sender: Any) {
        
        self.employeeStartedDate = self.employeeStartDateDatePicker.date
    }
    
    @IBAction func employeeSaveButtonPressed(_ sender: Any) {
        isInputValidationComplete { isComplete in
            if isComplete {
                self.employeePresenter.create(Employee(name: employeeNameTextField.text!, employeeID: employeeIDTextField.text!, jobShift: employeeJobShift, commissionPercent: Int.init(employeeCommisionPercentTextField.text!)!, startedDate: employeeStartedDate.ToFormatedDate(), state: true)) { isValidation in
                    if !isValidation {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
}
