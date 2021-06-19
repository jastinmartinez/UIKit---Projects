//
//  EmployeeTableViewController.swift
//  RentCar
//
//  Created by Jastin on 15/6/21.
//

import UIKit

class EmployeeTableViewController: UITableViewController {
 
    var employeePresenter = EmployeePresenter.shared

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
}
