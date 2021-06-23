//
//  EmployeeTableViewController.swift
//  RentCar
//
//  Created by Jastin on 15/6/21.
//

import UIKit

class EmployeeTableViewController: UITableViewController {
 
    private(set) var employeePresenter: EmployeePresenter = EmployeePresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        initServices()
    }
    
    func initServices()  {
        tableView.dataSource = self
        tableView.delegate = self
        employeePresenter.employeeViewDelegate = self
        employeePresenter.getAll()
    }
    
    @IBAction func addOrEditCustomerButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: Constant.segue.addOrEditEmployeeSegue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segue.addOrEditEmployeeSegue {
            let destinationAddOrEditEmployeeViewController = (segue.destination as! AddOrEditEmployeeViewController)
            destinationAddOrEditEmployeeViewController.employeePresenter = employeePresenter
            if let employee = sender {
                destinationAddOrEditEmployeeViewController.employee = employee as? Employee
            }
        }
    }
}

