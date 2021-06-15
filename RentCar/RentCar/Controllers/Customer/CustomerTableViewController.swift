//
//  CustomerViewController.swift
//  RentCar
//
//  Created by Jastin on 6/6/21.
//

import Foundation
import UIKit

class CustomerTableViewController: UITableViewController  {
    
    var customerPresenter = CustomerPresenter.shared
    
    override func viewDidLoad() {
        customerPresenter.getAll()
        tableView.dataSource = self
        tableView.delegate = self
        customerPresenter.customerViewDelegateProtocol = self
        super.viewDidLoad()
    }
    
    @IBAction func addCustomerButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: Constant.segue.addOrEditCustomerSegue, sender: nil)
    }
}
