//
//  AddOrEditRentViewController.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import UIKit

class AddOrEditRentViewController: UIViewController {
    
    @IBOutlet weak var rentEmployeePickerView: UIPickerView!
    @IBOutlet weak var rentVehiclerPickerVIew: UIPickerView!
    @IBOutlet weak var rentCustomerPickerView: UIPickerView!
    
    var rentPresenter: RentPresenter?
    var employeePresenter: EmployeePresenter?
    var customerPresenter: CustomerPresenter?
    var vehiclePresenter: VehiclePresenter?
    
    var employeeID: UUID?
    var vehicleID: UUID?
    var customerID: UUID?
    
    var rent: Rent?
    var isViewOnly: Bool?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        initViewDidLoad()
    }
    
    func initViewDidLoad() {
        
        rentEmployeePickerView.reloadAllComponents()
        rentVehiclerPickerVIew.reloadAllComponents()
        rentCustomerPickerView.reloadAllComponents()
        
        if let rent = rent, let isViewOnly = isViewOnly {
            if isViewOnly {
                
                initViewOnly(rent: rent)
            }
            else {
                
                initEditOnly(rent: rent)
            }
        }
        else {
            
            initAddOnly()
        }
    }
    
    func initAddOnly() {
        
        if vehiclePresenter!.vehicles.count > 0 {
            self.vehicleID = vehiclePresenter?.vehicles.first?.id
        }
        if employeePresenter!.employees.count > 0 {
            self.employeeID = employeePresenter?.employees.first?.id
        }
        if customerPresenter!.customers.count > 0 {
            self.customerID = customerPresenter?.customers.first?.id
        }
        
    }
    
    func initEditOnly(rent: Rent) {
        
        self.title = "Editar"
        rentModelToOutlet(rent: rent)
        
    }
    func initViewOnly(rent: Rent) {
        
        self.title = "Visualizar"
        EnableOrDisableOutlets().pickerView(pickerView: rentEmployeePickerView)
        EnableOrDisableOutlets().pickerView(pickerView: rentVehiclerPickerVIew)
        EnableOrDisableOutlets().pickerView(pickerView: rentCustomerPickerView)
        rentModelToOutlet(rent: rent)
    }
    
    @IBAction func rentNextViewControllerButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: Constant.segue.secondeAddOrEditRentSegue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constant.segue.secondeAddOrEditRentSegue {
            
            let destinationSecondAddOrEditRentViewController = segue.destination as! SecondAddOrEditRentViewController
            
            destinationSecondAddOrEditRentViewController.rentPresenter = rentPresenter
            destinationSecondAddOrEditRentViewController.rent = rent
            destinationSecondAddOrEditRentViewController.isViewOnly = isViewOnly
            destinationSecondAddOrEditRentViewController.customerID = customerID
            destinationSecondAddOrEditRentViewController.employeeID = employeeID
            destinationSecondAddOrEditRentViewController.vehicleID = vehicleID
            destinationSecondAddOrEditRentViewController.customerPresenter = customerPresenter
        }
    }
    
    func rentModelToOutlet(rent: Rent) {
        
        DispatchQueue.main.async { [self] in
            
            if vehiclePresenter!.vehicles.count > 0 {
                
                self.rentVehiclerPickerVIew.selectRow(vehiclePresenter!._vehicles.firstIndex(where: {$0.id == rent.vehicle.id})!, inComponent: 0, animated: true)
                
                self.vehicleID = rent.vehicle.id
            }
            
            if employeePresenter!.employees.count > 0 {
                
                self.rentEmployeePickerView.selectRow(employeePresenter!.employees.firstIndex(where: {$0.id == rent.employee.id})!, inComponent: 0, animated: true)
                
                self.employeeID = rent.employee.id
            }
            
            if customerPresenter!.customers.count > 0 {
                
                self.rentCustomerPickerView.selectRow(customerPresenter!._customers.firstIndex(where: {$0.id == rent.customer.id})!, inComponent: 0, animated: true)
                
                self.customerID = rent.customer.id
            }
        }
    }
}
