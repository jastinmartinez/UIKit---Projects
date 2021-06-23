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
    @IBOutlet weak var rentTotalTextField: RentAmoufOfDayTextField!
    @IBOutlet weak var rentCommentTextField: UITextField!
    @IBOutlet weak var rentAmountOfDaysTextField: UITextField!
    @IBOutlet weak var rentAmountOfDayErrorLabel: UILabel!
    @IBOutlet weak var rentDatePickerDate: UIDatePicker!
    
    var rentPresenter: RentPresenter?
    var customerPresenter: CustomerPresenter?
    
    var employeeID: UUID?
    var vehicleID: UUID?
    var customerID: UUID?
    var devolutionPresenter = DevolutionPresenter()
    
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
    }
    
    
    func initViewOnly(rent: Rent) {
        
        self.title = "Visualizar (2)"
        
        EnableOrDisableOutlets().datePicker(datePicker: rentDatePickerDate)
        EnableOrDisableOutlets().textField(textfield: rentAmountPerDayTextField)
        EnableOrDisableOutlets().textField(textfield: rentCommentTextField)
        EnableOrDisableOutlets().textField(textfield: rentAmountOfDaysTextField)
        rentModelToOutlet(rent: rent)
    }
    
    func rentModelToOutlet(rent: Rent) {
        
        self.rentAmountPerDayTextField.text = rent.amountPerDay.ToString()
        self.rentAmountOfDaysTextField.text = rent.amountOfDay.toString()
        self.rentCommentTextField.text = rent.comment
        self.rentDatePickerDate.date = rent.date.toDate()
        rentDate = rent.date.toDate()
        calculate()
        
    }
    
    @IBAction func rentSavedButtonPressed(_ sender: Any) {
        
        guard vehicleID != nil, customerID != nil, employeeID != nil, !rentAmountPerDayTextField.text!.isEmpty,!rentAmountOfDaysTextField.text!.isEmpty else { return }
        
        guard isViewOnly == false || isViewOnly == nil else { return }
        
       var customerWithNotEnoughCredit = false
        
        if let customer = customerPresenter!._customers.first(where: {$0.id == customerID}) {
          
            if customer.creditLimit < (Double(rentAmountPerDayTextField.text!)! * Double(rentAmountOfDaysTextField.text!)!)  {
                
                present(AlertView().show(title: "Cliente", message: "Cliente con credito Insuficiente"),animated: true,completion: nil)
                customerWithNotEnoughCredit = true
            }
        }
        
        guard customerWithNotEnoughCredit == false else {return}
    
        if let rent = rent {
            rentPresenter?.update(Rent( id: rent.id,employee: ParentModel(id: employeeID), customer: ParentModel(id:customerID), vehicle: ParentModel(id:vehicleID), date: rentDate.toString(), amountPerDay: Double.init(rentAmountPerDayTextField.text!)!, amountOfDay: Int.init(rentAmountOfDaysTextField.text!)!, comment: rentCommentTextField.text!, state: true))
        }
        else {
            rentPresenter?.create(Rent(employee: ParentModel(id: employeeID), customer: ParentModel(id:customerID), vehicle: ParentModel(id:vehicleID), date: rentDate.toString(), amountPerDay: Double.init(rentAmountPerDayTextField.text!)!, amountOfDay: Int.init(rentAmountOfDaysTextField.text!)!, comment: rentCommentTextField.text!, state: true))
        }
        
        self.navigationController?.popToViewController(navigationController!.viewControllers[navigationController!.viewControllers.count - 3], animated: true)
    }
    
    @IBAction func devolutionButtonPressed(_ sender: Any) {
        
        guard vehicleID != nil, customerID != nil, employeeID != nil, !rentAmountPerDayTextField.text!.isEmpty,!rentAmountPerDayTextField.text!.isEmpty else { return }
        
        guard isViewOnly == true else { return }
        
        if let rent = rent {
            
            guard rent.state else { return }
            
            var devolutionAmountOfDays = 0
            
            var rentDays = DateComponents()
            
            if rent.date.toDate() >= Date() {
                
                rentDays = Calendar.current.dateComponents([.day], from: Date(),to: rent.date.toDate())
            } else {
                
                rentDays = Calendar.current.dateComponents([.day], from: rent.date.toDate(),to: Date())
            }
        
            if var rentDay = rentDays.day {
                rentDay += 1
              
                if rentDay >= Int.init(rentAmountOfDaysTextField.text!)! {
                    
                    devolutionAmountOfDays = rentDay
                }
                else {
                
                    devolutionAmountOfDays = Int.init(rentAmountOfDaysTextField.text!)! - rentDay
                }
            }
            
            devolutionPresenter.create(Devolution(rent: ParentModel(id: rent.id), employee: ParentModel(id: employeeID), customer: ParentModel(id:customerID), vehicle: ParentModel(id:vehicleID), date: Date().toString(), amountPerDay: Double.init(rentAmountPerDayTextField.text!)!, amountOfDay: devolutionAmountOfDays, comment: rentCommentTextField.text!, state: false))
            
            rentPresenter?.update(Rent( id: rent.id,employee: ParentModel(id: employeeID), customer: ParentModel(id:customerID), vehicle: ParentModel(id:vehicleID), date: rentDate.toString(), amountPerDay: Double.init(rentAmountPerDayTextField.text!)!, amountOfDay: Int.init(rentAmountOfDaysTextField.text!)!, comment: rentCommentTextField.text!, state: false))
            
            self.navigationController?.popToViewController(navigationController!.viewControllers[navigationController!.viewControllers.count - 3], animated: true)
        }
    }
    
    @IBAction func rentDateDatePickerValueChanged(_ sender: Any) {
        
        self.rentDate = rentDatePickerDate.date
    }
    
}
