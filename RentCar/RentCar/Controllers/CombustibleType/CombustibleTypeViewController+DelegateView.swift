//
//  CombustibleTypeViewController+DelegateView.swift
//  RentCar
//
//  Created by Jastin on 2/6/21.
//

import Foundation
extension CombustibleTypeViewController: CombustibleTypeViewDelegate {
    func didArrayOfCombustibleChange() {
        self.combustibleTypeTableView.reloadData()
    } 
}
