//
//  CombustibleTypeViewController+DelegateView.swift
//  RentCar
//
//  Created by Jastin on 2/6/21.
//

import Foundation
extension MaintenanceViewController: MaintenanceViewDelegateProtocol {
    func didArrayChange() {
        self.maintTableView.reloadData()
    } 
}
