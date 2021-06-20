//
//  CustomerTableViewController+TableView.swift
//  RentCar
//
//  Created by Jastin on 8/6/21.
//

import Foundation
import UIKit

extension CustomerTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return customerPresenter.customers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.tableViewCell.customerTableViewCell) as! CustomerTableViewCell
        cell.bindDataToOulets(vm: customerPresenter.customers[indexPath.row])
        return cell
    }
    
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constant.segue.addOrEditCustomerSegue, sender: customerPresenter.customers[indexPath.row])
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segue.addOrEditCustomerSegue {
            let destinationAddOrEdirCustomerViewController = segue.destination as! AddOrEditCustomerViewController
            destinationAddOrEdirCustomerViewController.customerPresenter = customerPresenter
            if let customer = sender  {
                destinationAddOrEdirCustomerViewController.customer = (customer as? Customer)
            }
        }
    }
}
