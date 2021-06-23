//
//  AddCustomerViewController.swift
//  RentCar
//
//  Created by Jastin on 6/6/21.
//

import Foundation
import UIKit

class AddOrEditCustomerViewController: UIViewController {
    
    @IBOutlet weak var customerIDTextField: UITextField!
    @IBOutlet weak var customerNameTextField: UITextField!
    @IBOutlet weak var customerCreditCardTextField: UITextField!
    @IBOutlet weak var customerCreditLimitTextField: UITextField!
    @IBOutlet weak var customerPersonTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var customerIDErrorLabel: UILabel!
    @IBOutlet weak var customerCreditLimitErrorLabel: UILabel!
    @IBOutlet weak var customerCreditCardErrorLabel: UILabel!
    @IBOutlet weak var customerNameErrorLabel: UILabel!
    @IBOutlet weak var customerStateSwitch: UISwitch!
    
    var customerPresenter: CustomerPresenter?
    var customer: Customer?
    
    private var personType: String!
    
    override func viewDidLoad() {
        customerCreditLimitTextField.delegate = self
        customerIDTextField.delegate = self
        customerCreditCardTextField.delegate = self
        initEditMode()
        initTextFieldValidation()
        super.viewDidLoad()
    }
    
    @IBAction func customerPersonTypeSegmentControlValueChange(_ sender: Any) {
        
        personType = customerPersonTypeSegmentedControl.titleForSegment(at: customerPersonTypeSegmentedControl.selectedSegmentIndex)!
    }
    
    @IBAction func AddCustomerSaveButtonPressed(_ sender: Any) {
        isInputValidationComplete { isValid in
            if isValid {
                if customer != nil {
                    customerPresenter?.update(Customer(id: customer?.id,name: customerNameTextField.text!, customerID: customerIDTextField.text!, creditCard: customerCreditCardTextField.text!, creditLimit: Double.init(customerCreditLimitTextField.text!)! , personType:  personType, state: customerStateSwitch.isOn)) { validation in
                        if validation == false {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                   
                } else {
                    customerPresenter?.create(Customer(name: customerNameTextField.text!, customerID: customerIDTextField.text!, creditCard: customerCreditCardTextField.text!, creditLimit: Double.init(customerCreditLimitTextField.text!)! , personType:  personType, state: true)) { validation in
                        if validation == false {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
}


// MARK: Edit Mode
extension AddOrEditCustomerViewController {
    
    func initEditMode() {
        
        if let customer = customer {
            self.title = "Editar"
            self.customerIDTextField.text = customer.customerID
            self.customerNameTextField.text = customer.name
            self.customerCreditCardTextField.text = customer.creditCard
            self.customerCreditLimitTextField.text = customer.creditLimit.ToString()
            let personTypeIndex = StringInSegmentedControl().search(customer.personType, segmentedControl: customerPersonTypeSegmentedControl)
            if personTypeIndex > -1 {
                 self.customerPersonTypeSegmentedControl.selectedSegmentIndex = personTypeIndex
                 self.personType = self.customerPersonTypeSegmentedControl.titleForSegment(at: personTypeIndex)
            }
            customerStateSwitch.isHidden = false
            self.customerStateSwitch.isOn = customer.state
        }
        else {
            self.personType = customerPersonTypeSegmentedControl.titleForSegment(at: 0)!
        }
    }
}
