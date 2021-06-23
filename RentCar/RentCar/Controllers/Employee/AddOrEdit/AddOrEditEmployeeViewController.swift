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
    
    var employeePresenter: EmployeePresenter?
    var employee: Employee?
   
    private var employeeJobShift: String!
    private var employeeStartedDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewDidiLoad()
    }
    
    func initViewDidiLoad()
    {
        initOutletsValidationEvent()
        initEditMode()
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
                if let employee = employee {
                    self.employeePresenter?.update(Employee(id: employee.id!,name: employeeNameTextField.text!, employeeID: employeeIDTextField.text!, jobShift: employeeJobShift, commissionPercent: Int.init(employeeCommisionPercentTextField.text!)!, startedDate: employeeStartedDate.toString(), state: employeeStateSwitch.isOn)) { isValidation in
                        if !isValidation {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                } else  {
                    self.employeePresenter?.create(Employee(name: employeeNameTextField.text!, employeeID: employeeIDTextField.text!, jobShift: employeeJobShift, commissionPercent: Int.init(employeeCommisionPercentTextField.text!)!, startedDate: employeeStartedDate.toString(), state: true)) { isValidation in
                        if !isValidation {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
}


// MARK: Edit Mode
extension AddOrEditEmployeeViewController {
    
    func initEditMode() {
        if let employee = employee {
            self.title = "Editar"
            self.employeeIDTextField.text = employee.employeeID
            self.employeeNameTextField.text = employee.name
            let jobShiftIndex = StringInSegmentedControl().search(employee.jobShift, segmentedControl: employeeJobShiftSegementedControl)
            if jobShiftIndex != -1 {
                self.employeeJobShiftSegementedControl.selectedSegmentIndex = jobShiftIndex
                self.employeeJobShift = self.employeeJobShiftSegementedControl.titleForSegment(at: jobShiftIndex)
            }
            self.employeeCommisionPercentTextField.text = employee.commissionPercent.toString()
            self.employeeStartDateDatePicker.date = employee.startedDate.toDate()
            self.employeeStartedDate = employee.startedDate.toDate()
            self.employeeStateSwitch.isOn = employee.state
            self.employeeStateSwitch.isHidden = false
        }
        else {
            employeeJobShift = employeeJobShiftSegementedControl.titleForSegment(at: 0)
            employeeStartedDate = employeeStartDateDatePicker.date
        }
    }
}
