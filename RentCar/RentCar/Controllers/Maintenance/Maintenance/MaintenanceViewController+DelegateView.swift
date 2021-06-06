//
//  CombustibleTypeViewController+DelegateView.swift
//  RentCar
//
//  Created by Jastin on 2/6/21.
//

import Foundation
extension MaintenanceViewController: MaintenanceViewDelegateProtocol {
    
    func didErrorOcurred(title: String, message: String) {
        
        self.present(AlertView().show(title: title, message: message), animated: true, completion: nil)
    }
    
    func didArrayChange() {
        self.maintTableView.reloadData()
    } 
}
