//
//  VehicleTableViewController+ViewDelegate.swift
//  RentCar
//
//  Created by Jastin on 21/6/21.
//

import Foundation

extension VehicleCollectionView: VehicleViewDelegateProtocol {
    
    func didVehicleArrayChange() {
        self.collectionView.reloadData()
    }
    
    func didErrorOcurred(title: String, message: String) {
        present(AlertView().show(title: title, message: message),animated: true)
    }
}
