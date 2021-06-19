//
//  CustomerViewController+ViewDelegate.swift
//  RentCar
//
//  Created by Jastin on 8/6/21.
//

import Foundation
import UIKit
extension CustomerTableViewController: CustomerViewDelegateProtocol {
    
    func didErrorOcurred(title: String, message: String) {
        present(AlertView().show(title: title, message: message), animated: true, completion: nil)
    }
    
    func didCustomersChange() {
        self.tableView.reloadData()
    }
}
