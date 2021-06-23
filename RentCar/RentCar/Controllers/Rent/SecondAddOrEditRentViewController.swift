//
//  SecondAddOrEditRentViewController.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import UIKit

class SecondAddOrEditRentViewController: UIViewController {
    
    @IBOutlet weak var rentAmountPerDayTextField: UITextField!
    @IBOutlet weak var rentAmountPerDayErrorLabel: UILabel!
    @IBOutlet weak var rentCommentTextField: UITextField!
    @IBOutlet weak var rentAmountOfDaysTextField: UITextField!
    @IBOutlet weak var rentAmountOfDayErrorLabel: UILabel!
    @IBOutlet weak var rentDatePickerDate: UIDatePicker!
    @IBOutlet weak var rentStateSwitch: UISwitch!
    
    var rentPresenter: RentPresenter?
    var employeeID: UUID?
    var vehicleID: UUID?
    var customerID: UUID?
    
    var rent: Rent?
    var isViewOnly: Bool?
    private var rentDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewDidLoad()
    }
    
    func initViewDidLoad() {
        
        initValidation()
        
        if let rent = rent, let isViewOnly = isViewOnly {
            
            if isViewOnly {
                
                initViewOnly(rent: rent)
                
            } else {
                
                initEditOnly(rent: rent)
            }
        }
        else {
            
            initAddOnly()
        }
    }
    
    func initAddOnly() {
        
        self.title = "Nuevo (2)"
        rentDate = rentDatePickerDate.date
    }
    
    func initEditOnly(rent: Rent){
        
        self.title = "Editar (2)"
        rentModelToOutlet(rent: rent)
        EnableOrDisableOutlets().switchs(switchs: rentStateSwitch,isHidden: false)
    }
    @IBAction func rentDateDatePickerValueChanged(_ sender: Any) {
        self.rentDate = rentDatePickerDate.date
    }
    
    func initViewOnly(rent: Rent) {
        
        self.title = "Visualizar (2)"
        
        EnableOrDisableOutlets().datePicker(datePicker: rentDatePickerDate)
        EnableOrDisableOutlets().textField(textfield: rentAmountPerDayTextField)
        EnableOrDisableOutlets().textField(textfield: rentCommentTextField)
        EnableOrDisableOutlets().textField(textfield: rentAmountOfDaysTextField)
        EnableOrDisableOutlets().switchs(switchs: rentStateSwitch,isEnabled: false, isHidden: false)
        rentModelToOutlet(rent: rent)
    }
    
    func rentModelToOutlet(rent: Rent) {
        
        self.rentAmountPerDayTextField.text = rent.amountPerDay.ToString()
        self.rentAmountOfDaysTextField.text = rent.amountOfDay.toString()
        self.rentCommentTextField.text = rent.comment
        self.rentDatePickerDate.date = rent.date.toDate()
        self.rentStateSwitch.isOn = rent.state
        rentDate = rent.date.toDate()
        
    }
    
    @IBAction func rentSavedButtonPressed(_ sender: Any) {
     
        guard vehicleID != nil, customerID != nil, employeeID != nil, !rentAmountPerDayTextField.text!.isEmpty,!rentAmountPerDayTextField.text!.isEmpty else { return }
        
        guard isViewOnly == false || isViewOnly == nil else { return }
       
        if let rent = rent {
            rentPresenter?.update(Rent( id: rent.id,employee: ParentModel(id: employeeID), customer: ParentModel(id:customerID), vehicle: ParentModel(id:vehicleID), date: rentDate.toString(), amountPerDay: Double.init(rentAmountPerDayTextField.text!)!, amountOfDay: Int.init(rentAmountOfDaysTextField.text!)!, comment: rentCommentTextField.text!, state: true))
        }
        else {
            rentPresenter?.create(Rent(employee: ParentModel(id: employeeID), customer: ParentModel(id:customerID), vehicle: ParentModel(id:vehicleID), date: rentDate.toString(), amountPerDay: Double.init(rentAmountPerDayTextField.text!)!, amountOfDay: Int.init(rentAmountOfDaysTextField.text!)!, comment: rentCommentTextField.text!, state: true))
        }
        
        self.navigationController?.popToViewController(navigationController!.viewControllers[navigationController!.viewControllers.count - 3], animated: true)
    }
}
